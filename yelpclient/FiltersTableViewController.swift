//
//  FiltersTableViewController.swift
//  yelpclient
//
//  Created by Jesse Smith on 9/20/14.
//  Copyright (c) 2014 Jesse Smith. All rights reserved.
//

import UIKit

@objc protocol FilterTableDelegate {
    func supWithYouBro(message: String)
}

class FiltersTableController: UITableViewController  {
    
    var delegate: FilterTableDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        var vcs = self.navigationController?.viewControllers
        self.delegate = vcs?[0] as? FilterTableDelegate
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.delegate?.supWithYouBro("bananas 4 dayz")
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let table = self.tableView
        
        let cell = table.dequeueReusableCellWithIdentifier("filtercell", forIndexPath: indexPath) as FilterCell
        cell.filterName.text = "guy: \(indexPath.row)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Some Header \(section)"
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75;
    }
}
