//
//  ViewController.swift
//  yelpclient
//
//  Created by Jesse Smith on 9/20/14.
//  Copyright (c) 2014 Jesse Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var resultsTableView: UITableView!
    var restaurantResults: [Restaurant] = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getResults()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = resultsTableView.dequeueReusableCellWithIdentifier("yelpcell") as YelpCellTableViewCell

        cell.descriptionLabel.text = restaurantResults[indexPath.row].description
        
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
////        let detailsViewController = MovieDetailsViewController(nibName: "MovieDetails", bundle: nil)
////        
////        let movieDictionary = self.moviesArray![indexPath.row] as NSDictionary
////        let postersDict = movieDictionary["posters"] as NSDictionary
////        
////        let thumbUrl = postersDict["thumbnail"] as NSString
////        detailsViewController.fullImageUrl = thumbUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
////        detailsViewController.movieDescriptionDict = movieDictionary
////        
////        self.navigationController?.pushViewController(detailsViewController, animated: true)
//    }
    
    func getResults() {
        restaurantResults.append(Restaurant(description: "restaurant 1 is yummy"))
        restaurantResults.append(Restaurant(description: "restaurant 2 is lame"))
    }
}

