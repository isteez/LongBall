//
//  ScheduleTableViewController.swift
//  LongBall
//
//  Created by Stephen Kyles on 12/24/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var allWeeks: NSArray!
    var allWeekTitles: NSMutableArray = []
    
    @IBOutlet weak var eventTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* 
        
        pick a week
        pick date / time for # of days
        (start / end time set to 15 min - default)
        
        */
        
        for week in allWeeks {
            var data = week as DataObject
            var weekTitle = data.GetTitle() as NSString
            
            self.allWeekTitles.addObject(weekTitle)
        }
        
        self.allWeekTitles.addObject("All 4 Weeks")
        self.allWeekTitles.addObject("All 4 Weeks, including post training")
        
        //eventTitleTextField.userInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func showPicker() {
        var picker = UIPickerView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height))
        picker.dataSource = self
        picker.delegate = self
        
        eventTitleTextField.inputView = picker
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.allWeekTitles.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.allWeekTitles.objectAtIndex(row) as NSString
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.allWeekTitles.count
//    }
//
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
//
//        // Configure the cell...
//        cell.textLabel?.text = self.allWeekTitles.objectAtIndex(indexPath.row) as NSString
//        
//        return cell
//    }
//
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.performSegueWithIdentifier("PickTitle", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "PickTitle") {
            var pickerView = segue.destinationViewController as PickerViewController
            
            pickerView.allWeeks = self.allWeekTitles
        }
    }
}
