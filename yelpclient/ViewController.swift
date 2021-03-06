//
//  ViewController.swift
//  yelpclient
//
//  Created by Jesse Smith on 9/20/14.
//  Copyright (c) 2014 Jesse Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FilterTableDelegate {
    
    var client: YelpClient!
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "BeBsBEuYUeHESjJ-gB-3Mw"
    let yelpConsumerSecret = "1t3Nw-VC0kwAJRK0NQskWV6Pk9o"
    let yelpToken = "WKnNK35JBfL5uIuKKMQBigb75WB6xZKH"
    let yelpTokenSecret = "190x3RR1Be_xmB8t5z-4AD8Mjq4"
    
    @IBOutlet weak var resultsTableView: UITableView!
    var businesses: [Restaurant] = [Restaurant]()
    let searchBarTop: UISearchBar = UISearchBar()
    
    var term: String = ""
    var categories: String = ""
    var sortMetric: Int = 0
    

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.resultsTableView.estimatedRowHeight = 200
        self.resultsTableView.rowHeight = UITableViewAutomaticDimension
        
        self.searchBarTop.delegate = self
        self.searchDisplayController?.displaysSearchBarInNavigationBar = true;
        self.navigationItem.titleView = self.searchBarTop
        
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        self.doSearch()
    }
    
    func doSearch() {
        client.searchWithTerm(self.term, categories: self.categories, sortBy: self.sortMetric, success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
            self.businesses = []
            var dictArray = responseObject["businesses"] as? NSArray
            
            for biz in dictArray! {
                var biz = biz as NSDictionary
                var res = Restaurant(dataDict: biz)
                self.businesses.append(res)
            }
            self.resultsTableView.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.navigationBar.endEditing(true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCellWithIdentifier("yelpcell") as YelpCellTableViewCell
        let biz = businesses[indexPath.row]
        let location = biz.location

        cell.nameLabel.text = "\(indexPath.row+1). \(biz.name)"
        cell.dollarsLabel.text = "$$"
        var cats = biz.categories
        cell.categoriesLabel.text = ", ".join(cats.map({ "\($0)" }))
        cell.addressLabel.text = "\(location!)"
        
        if (!biz.image_url.isEmpty) {
            cell.imageIcon.setImageWithURL(NSURL(string: biz.image_url))
        }
        if (!biz.rating_img_url.isEmpty) {
            cell.ratingImage.setImageWithURL(NSURL(string: biz.rating_img_url))
        }
        
        return cell
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        self.term = searchBar.text
        
        self.doSearch()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText == "") {
            self.term = ""
            self.doSearch()
        }
    }
    
    func returnSearchParams(searchParams: SearchResults) {
        var list: [String] = []
        if (searchParams.thai) {
            list.append("thai")
        }
        if (searchParams.chinese) {
            list.append("chinese")
        }
        if (searchParams.italian) {
            list.append("italian")
        }
        if (searchParams.mexican) {
            list.append("mexican")
        }
        
        self.sortMetric = searchParams.sortMetric
        
        
        self.categories = ",".join(list)
        self.doSearch()
    }
}

