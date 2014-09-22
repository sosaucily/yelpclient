//
//  FiltersTableViewController.swift
//  yelpclient
//
//  Created by Jesse Smith on 9/20/14.
//  Copyright (c) 2014 Jesse Smith. All rights reserved.
//

import UIKit

@objc protocol FilterTableDelegate {
    func returnSearchParams(searchParams: SearchResults)
}

class SearchResults: NSObject {
    var sortMetric: String = ""
}

class FiltersTableController: UITableViewController, SwitchFilterCellDelegate {
    
    let sectionHeaders = ["Sort by", "bla2", "bla3"]
    
    var searchParams: SearchResults = SearchResults()
    
    var delegate: FilterTableDelegate?
    
    var searchButton: UIBarButtonItem = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        var vcs = self.navigationController?.viewControllers
        self.delegate = vcs?[0] as? FilterTableDelegate
        
        self.searchButton = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.Bordered, target: self, action: "doSearch")
        self.navigationItem.rightBarButtonItem = self.searchButton;
    }
    
    func doSearch() {
        self.delegate?.returnSearchParams(self.searchParams)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
//    override func viewDidDisappear(animated: Bool) {}

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return 3
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let table = self.tableView
        
        if (indexPath.row == 0){
            let cell = table.dequeueReusableCellWithIdentifier("dropdownFilterCell", forIndexPath: indexPath) as DropdownFilterCell
            cell.delegate = self
            return cell
        } else {
            let cell = table.dequeueReusableCellWithIdentifier("switchFilterCell", forIndexPath: indexPath) as SwitchFilterCell
            cell.filterName.text = "sup guy"
            return cell
        }
    }
    
    func sortValue(message: String) {
        self.searchParams.sortMetric = message
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(sectionHeaders[section])"
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75;
    }
}
