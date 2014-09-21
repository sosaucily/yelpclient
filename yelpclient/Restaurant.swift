//
//  Restaurant.swift
//  yelpclient
//
//  Created by Jesse Smith on 9/20/14.
//  Copyright (c) 2014 Jesse Smith. All rights reserved.
//

import Foundation

class Restaurant: NSObject {
    var dataDict: NSDictionary = NSDictionary()
    var categories: [AnyObject] = []
    
    var image_url = ""
    var name = "SomePlace"
    
    var rating_img_url = ""
    var review_count = 0
    
    var location: Location? = nil
    
    init(dataDict: NSDictionary) {
        self.name = dataDict["name"] as NSString
        
        var catTuples = dataDict["categories"] as NSArray
        for cat in catTuples {
            self.categories.append(cat[0])
        }
        
        self.location = Location(
            dataDict: dataDict["location"] as NSDictionary
        )
        self.image_url = dataDict["image_url"] as NSString
        self.rating_img_url = dataDict["rating_img_url"] as NSString
        println(dataDict["review_count"])
        self.review_count = dataDict["review_count"] as Int
    }
    
    func description() -> String{
        return "Name: \(self.name) - Categories: \(self.self.categories) - Location: \(self.location)\n"
    }
}

class Location: NSObject {
    var address: [AnyObject] = []
    var city = "San Francisco"
    var country_code = "US"
    var cross_streets = "Olive St & Ellis St"
    var display_address = ("730 Larkin St", "Tenderloin", "San Francisco, CA 94109")
    var neighborhoods: [AnyObject] = []
    var postal_code = "94109"
    var state_code = "CA"
    
    init(dataDict: NSDictionary) {
        self.address = dataDict["address"] as NSArray
        self.neighborhoods = dataDict["neighborhoods"] as NSArray
    }
    func description() -> String! {
        return "\(self.address[0]), \(self.neighborhoods[0])"
    }
}