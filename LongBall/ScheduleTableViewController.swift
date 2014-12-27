//
//  ScheduleTableViewController.swift
//  LongBall
//
//  Created by Stephen Kyles on 12/24/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

import UIKit
import EventKit

class ScheduleTableViewController: UITableViewController, SKDatePickerDelegate {
    var data: DataObject!
    var allWeekTitles: NSMutableArray = []
    var daysPerWeek: NSInteger!
    var datesArray: NSMutableArray = []
    var eventsArray: NSMutableArray = [0,0,0,0,0,0]
    var calendar: EKCalendar!
    
    @IBOutlet weak var eventTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add To Calendar"
        
        self.daysPerWeek = self.data.GetDaysPerWeek().integerValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func goBack() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
        var cellIdentifier = "Cell"
        
        if self.daysPerWeek == 2 {
            if indexPath.section == 1 || indexPath.section == 2 {
                cellIdentifier = "Cell2"
            }
        } else if self.daysPerWeek == 3 {
            if indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 {
                cellIdentifier = "Cell2"
            }
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        return CellLogic(cell, indexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.daysPerWeek == 2 {
            if indexPath.section == 3 {
                AddToCalendar(self.eventsArray[0] as NSDate, endDate: self.eventsArray[2] as NSDate)
                AddToCalendar(self.eventsArray[1] as NSDate, endDate: self.eventsArray[3] as NSDate)
        
                self.dismissViewControllerAnimated(true, completion: nil)
            } else if indexPath.section != 0 {
                self.performSegueWithIdentifier("ShowPicker", sender: indexPath)
            }
        } else if self.daysPerWeek == 3 {
            if indexPath.section == 4 {
                AddToCalendar(self.eventsArray[0] as NSDate, endDate: self.eventsArray[3] as NSDate)
                AddToCalendar(self.eventsArray[1] as NSDate, endDate: self.eventsArray[4] as NSDate)
                AddToCalendar(self.eventsArray[2] as NSDate, endDate: self.eventsArray[5] as NSDate)
                
                self.dismissViewControllerAnimated(true, completion: nil)
            } else if indexPath.section != 0 {
                self.performSegueWithIdentifier("ShowPicker", sender: indexPath)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Table view cell logic
    
    func CellLogic(cell: UITableViewCell, indexPath: NSIndexPath) -> UITableViewCell {
        cell.textLabel?.textColor = .blackColor()
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        
        var title = self.data.GetTitle() as NSString
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy h:mm a"
        
        var startDate = NSDate()
        for item in self.datesArray {
            var dateArray = item as NSArray
            var dateArrayIndexPath = dateArray.objectAtIndex(1) as NSIndexPath
            
            if dateArrayIndexPath.section == indexPath.section &&
                dateArrayIndexPath.row == indexPath.row {
                startDate = dateArray.objectAtIndex(0) as NSDate
            }
        }
        var date = formatter.stringFromDate(startDate)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "LongBall Training: \(title)"
            cell.textLabel?.textAlignment = .Center
            cell.userInteractionEnabled = false
        }
        
        if self.daysPerWeek == 2 {
            if indexPath.section == 1 || indexPath.section == 2 {
                if indexPath.row == 0 {
                    cell.textLabel?.text = "Starts"
                    cell.textLabel?.textAlignment = .Left
                    
                    cell.detailTextLabel?.text = date
                    self.eventsArray[indexPath.section - 1] = startDate
                } else {
                    cell.textLabel?.text = "Ends"
                    cell.textLabel?.textAlignment = .Left
                    
                    cell.detailTextLabel?.text = date
                    self.eventsArray[indexPath.section + 1] = startDate
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
                    cell.textLabel?.text = "Starts"
                    cell.textLabel?.textAlignment = .Left
                    
                    cell.detailTextLabel?.text = date
                    self.eventsArray[indexPath.section - 1] = startDate
                } else {
                    cell.textLabel?.text = "Ends"
                    cell.textLabel?.textAlignment = .Left
                    
                    cell.detailTextLabel?.text = date
                    self.eventsArray[indexPath.section + 2] = startDate
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
    
    // MARK: - GetDate
    
    func GetDate(date: NSDate, indexPath: NSIndexPath) {
        self.datesArray.addObject(NSArray(objects: date, indexPath))
        self.tableView.reloadData()
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Add to calendar
    
    func AddToCalendar(startDate: NSDate, endDate: NSDate) {
        var eventStore = EKEventStore()
        var event = EKEvent(eventStore: eventStore)
        var longBallCal: EKCalendar!
        
        if self.data.GetTitle() == "Weekly Routine" {
            var repeat = EKRecurrenceRule(recurrenceWithFrequency: EKRecurrenceFrequencyWeekly, interval: 1, end: nil)
            event.recurrenceRules = [repeat]
        }

        if self.calendar == nil {
            SetCalendar(eventStore)
        }
        
        eventStore.requestAccessToEntityType(EKEntityType(), completion: { (granted, error) -> Void in
            if granted {
                event.title = NSString(format: "LongBall Training: %@", self.data.GetTitle())
                event.startDate = startDate
                event.endDate = endDate
                event.calendar = self.calendar
                eventStore.saveEvent(event, span: EKSpanThisEvent, error: nil)
            }
        })
    }
    
    func SetCalendar(eventStore: EKEventStore) {
        var calendarTitle = "LongBall Training"
        var currentCalendars = eventStore.calendarsForEntityType(EKEntityTypeEvent) as NSArray
        var sortBy = NSPredicate(format: "title matches %@", calendarTitle)
        var filtered = currentCalendars.filteredArrayUsingPredicate(sortBy!) as NSArray
        
        if filtered.count > 0 {
            self.calendar = filtered.firstObject as EKCalendar
        } else {
            self.calendar = EKCalendar(forEntityType: EKEntityTypeEvent, eventStore: eventStore)
            self.calendar.title = "LongBall Training"
            self.calendar.source = eventStore.defaultCalendarForNewEvents.source
            eventStore.saveCalendar(self.calendar, commit: true, error: nil)
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPicker" {
            var pickerView = segue.destinationViewController as PickerViewController
            var indexPath = sender as NSIndexPath
            
            pickerView.delegate = self
            pickerView.indexPath = indexPath
        }
    }
}
