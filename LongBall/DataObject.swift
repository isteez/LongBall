//
//  DataObject.swift
//  LongBall
//
//  Created by Stephen Kyles on 12/24/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

import UIKit

class DataObject: NSObject {
    var weekAttributes: NSMutableDictionary!
    
    init(dictionary: NSDictionary) {
        self.weekAttributes = NSMutableDictionary(dictionary: dictionary)
    }
    
    func GetTitle() -> NSString {
        return self.weekAttributes.valueForKey("WeekTitle") as NSString
    }
    
    func GetDaysPerWeek() -> NSString {
        return self.weekAttributes.valueForKey("DaysPerWeek") as NSString
    }
    
    func GetOverspeedSets() -> NSString {
        return self.weekAttributes.valueForKey("OverspeedSets") as NSString
    }
    
    func GetOverspeedReps() -> NSString {
        return self.weekAttributes.valueForKey("OverspeedReps") as NSString
    }
    
    func GetWeightedSets() -> NSString {
        return self.weekAttributes.valueForKey("OverspeedWeightedSets") as NSString
    }
    
    func GetWeightedReps() -> NSString {
        return self.weekAttributes.valueForKey("OverspeedWeightedReps") as NSString
    }
}
