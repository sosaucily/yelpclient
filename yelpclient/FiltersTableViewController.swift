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
    var sortMetric: Int = 0
    var thai: Bool = true
    var mexican: Bool = true
    var chinese: Bool = true
    var italian: Bool = true
}

class FiltersTableController: UITableViewController, DropdownFilterCellDelegate, SwitchFilterCellDelegate {
    
    let sectionHeaders = ["Sort by", "Categories"]
    let categories = ["thai","mexican", "chinese", "italian"]
    
    var searchParams: SearchResults = SearchResults()
    
    var delegate: FilterTableDelegate?
    
    var searchButton: UIBarButtonItem = UIBarButtonItem()
    
    var expanded: Bool = false

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
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            if (!self.expanded) {
                return 3
            } else {
                return 4
            }
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let table = self.tableView
        
        if (indexPath.section == 0){
            let cell = table.dequeueReusableCellWithIdentifier("dropdownFilterCell", forIndexPath: indexPath) as DropdownFilterCell
            cell.delegate = self
            return cell
        } else if (indexPath.row == 2 && !self.expanded) {
            let cell = table.dequeueReusableCellWithIdentifier("seeAllCell", forIndexPath: indexPath) as SeeAllCell
            return cell
        } else {
            let cell = table.dequeueReusableCellWithIdentifier("switchFilterCell", forIndexPath: indexPath) as SwitchFilterCell
            cell.filterName.text = categories[indexPath.row]
            cell.filterSwitch.addTarget(cell, action: "triggerSwitch", forControlEvents: UIControlEvents.ValueChanged)
            cell.delegate = self
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (!self.expanded) {
            if (indexPath.section == 1 && indexPath.row == 2) {
                self.expanded = true
                self.tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    func sortValue(message: String) {
        var id = 0
        switch message {
        case "best match":
            id = 1
        case "distance":
            id = 2
        case "highest rated":
            id = 3
        default:
            id = 0
        }
        
        self.searchParams.sortMetric = id
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(sectionHeaders[section])"
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75;
    }
    
    func setSwitch(message: String) {
        println(message)
        switch message {
        case "thai":
            searchParams.thai = !searchParams.thai
        case "mexican":
            searchParams.mexican = !searchParams.mexican
        case "chinese":
            searchParams.chinese = !searchParams.chinese
        case "italian":
            searchParams.italian = !searchParams.italian
        default:
            break
        }
    }
}
