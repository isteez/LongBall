//
//  ScheduleTableViewController.swift
//  LongBall
//
//  Created by Stephen Kyles on 12/24/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

import UIKit
import EventKit

class ScheduleTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var data: DataObject!
    var allWeekTitles: NSMutableArray = []
    var daysPerWeek: NSInteger!
    
    @IBOutlet weak var eventTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add To Calendar"
        
        self.daysPerWeek = self.data.GetDaysPerWeek().integerValue
        
        //DatePicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func goBack() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func DatePicker() {
        var picker = UIDatePicker(frame: CGRectMake(0, 0, view.frame.width, view.frame.height))
        picker.backgroundColor = .whiteColor()
        
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
        eventTitleTextField.text = self.allWeekTitles.objectAtIndex(row) as NSString
        eventTitleTextField.resignFirstResponder()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2 + self.daysPerWeek
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.daysPerWeek == 2 {
            if section == 1 || section == 2 {
                return 2
            }
        } else if self.daysPerWeek == 3 {
            if section == 1 || section == 2 || section == 3 {
                return 2
            }
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.daysPerWeek == 2 {
            if section == 1 || section == 2 {
                return "Day \(section)"
            }
        } else if self.daysPerWeek == 3 {
            if section == 1 || section == 2 || section == 3 {
                return "Day \(section)"
            }
        }
        return nil
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.textColor = .blackColor()
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        
        var title = self.data.GetTitle() as NSString
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy h:mm a"
        var now = NSDate()
        var date = formatter.stringFromDate(now)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "LongBall - \(title)"
            cell.textLabel?.textAlignment = .Center
            cell.userInteractionEnabled = false
        }
        
        if self.daysPerWeek == 2 {
            if indexPath.section == 1 || indexPath.section == 2 {
                if indexPath.row == 0 {
                    cell.textLabel?.text = "Start Date:"
                    cell.textLabel?.textAlignment = .Left
                    
                    cell.detailTextLabel?.text = date
                } else {
                    cell.textLabel?.text = "End Date:"
                    cell.textLabel?.textAlignment = .Left
                    
                    cell.detailTextLabel?.text = date
                }
                
                cell.userInteractionEnabled = true
            } else if indexPath.section == 3 {
                cell.textLabel?.text = "Create"
                cell.textLabel?.textAlignment = .Center
                cell.textLabel?.textColor = UIColorFromHex(0x196CE8)
                
                cell.userInteractionEnabled = true
            }
        } else if self.daysPerWeek == 3 {
            if indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 {
                if indexPath.row == 0 {
                    cell.textLabel?.text = "Start Date:"
                    cell.textLabel?.textAlignment = .Left
                    
                    cell.detailTextLabel?.text = date
                } else {
                    cell.textLabel?.text = "End Date:"
                    cell.textLabel?.textAlignment = .Left
                    
                    cell.detailTextLabel?.text = date
                }
                
                cell.userInteractionEnabled = true
            } else if indexPath.section == 4 {
                cell.textLabel?.text = "Create"
                cell.textLabel?.textAlignment = .Center
                cell.textLabel?.textColor = UIColorFromHex(0x196CE8)
                
                cell.userInteractionEnabled = true
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.daysPerWeek == 2 {
            if indexPath.section == 3 {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        } else if self.daysPerWeek == 3 {
            if indexPath.section == 4 {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Add to calendar
    
    func AddToCalendar(startDate: NSDate, endDate: NSDate) {
        var eventStore = EKEventStore()
        var event = EKEvent(eventStore: eventStore)
        
        eventStore.requestAccessToEntityType(EKEntityType(), completion: { (granted, error) -> Void in
            if granted {
                event.startDate = startDate
                event.endDate = endDate
                
                event.calendar = eventStore.defaultCalendarForNewEvents
                eventStore.saveEvent(event, span: EKSpanThisEvent, error: nil)
            }
        })
    }
}
