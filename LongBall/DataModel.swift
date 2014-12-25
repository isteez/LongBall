//
//  DataModel.swift
//  LongBall
//
//  Created by Stephen Kyles on 12/24/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    var allWeeks: NSMutableArray = []
    
    override init() {
        var filePath = NSBundle.mainBundle().pathForResource("Data", ofType: "json")
        var data = NSData(contentsOfFile: filePath!)
        var json = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSArray
        
        for weekTuple in json {
            var week = DataObject(dictionary: weekTuple as NSDictionary)
            self.allWeeks.addObject(week)
        }
    }
    
    func GetAllWeeks() -> NSArray {
        return self.allWeeks
    }
    
    func GetNumberOfWeeks() -> NSInteger {
        return self.allWeeks.count
    }
}
