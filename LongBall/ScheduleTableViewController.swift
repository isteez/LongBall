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
    var datesArray: NSMutableArray = [[0],[0],[0],[0],[0],[0]]
    var eventsArray: NSMutableArray = [[0],[0],[0],[0],[0],[0]]
    var calendar: EKCalendar!
    var eventStore = EKEventStore()
    var canAddToCalendar: Bool = false
    
    @IBOutlet weak var eventTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add To Calendar"
        
        self.daysPerWeek = self.data.GetDaysPerWeek().integerValue
        
        self.eventStore.requestAccessToEntityType(EKEntityType(), completion: { (granted, error) -> Void in
            if granted {
                self.canAddToCalendar = true
            }
        })
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
                if AddToCalendar(self.eventsArray[0][0] as NSObject, endDate: self.eventsArray[2][0] as NSObject) {
                    if AddToCalendar(self.eventsArray[1][0] as NSObject, endDate: self.eventsArray[3][0] as NSObject) {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
            } else if indexPath.section != 0 {
                self.performSegueWithIdentifier("ShowPicker", sender: indexPath)
            }
        } else if self.daysPerWeek == 3 {
            if indexPath.section == 4 {
                if AddToCalendar(self.eventsArray[0][0] as NSObject, endDate: self.eventsArray[3][0] as NSObject) {
                    if AddToCalendar(self.eventsArray[1][0] as NSObject, endDate: self.eventsArray[4][0] as NSObject) {
                        if AddToCalendar(self.eventsArray[2][0] as NSObject, endDate: self.eventsArray[5][0] as NSObject) {
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                    }
                }
            } else if indexPath.section != 0 {
                self.performSegueWithIdentifier("ShowPicker", sender: indexPath)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Table view cell logic
    
    func CellLogic(cell: UITableViewCell, indexPath: NSIndexPath) -> UITableViewCell {
        var detailDefault = "tap to set"
        
        cell.textLabel?.textColor = .blackColor()
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        
        var title = self.data.GetTitle() as NSString
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy h:mm a"
        
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
                    
                    if self.datesArray[indexPath.section - 1] as NSObject == [0] {
                        cell.detailTextLabel?.text = detailDefault
                    } else {
                        cell.detailTextLabel?.text =
                            formatter.stringFromDate(self.datesArray[indexPath.section - 1][0] as NSDate)
                    }
                    self.eventsArray[indexPath.section - 1] = self.datesArray[indexPath.section - 1]
                } else {
                    cell.textLabel?.text = "Ends"
                    cell.textLabel?.textAlignment = .Left
                    
                    if self.datesArray[indexPath.section + 1] as NSObject == [0] {
                        cell.detailTextLabel?.text = detailDefault
                    } else {
                        cell.detailTextLabel?.text =
                            formatter.stringFromDate(self.datesArray[indexPath.section + 1][0] as NSDate)
                    }
                    self.eventsArray[indexPath.section + 1] = self.datesArray[indexPath.section + 1]
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
                    
                    if self.datesArray[indexPath.section - 1] as NSObject == [0] {
                        cell.detailTextLabel?.text = detailDefault
                    } else {
                        cell.detailTextLabel?.text =
                            formatter.stringFromDate(self.datesArray[indexPath.section - 1][0] as NSDate)
                    }
                    self.eventsArray[indexPath.section - 1] = self.datesArray[indexPath.section - 1]
                    
                } else {
                    cell.textLabel?.text = "Ends"
                    cell.textLabel?.textAlignment = .Left
                    
                    if self.datesArray[indexPath.section + 2] as NSObject == [0] {
                        cell.detailTextLabel?.text = detailDefault
                    } else {
                        cell.detailTextLabel?.text =
                            formatter.stringFromDate(self.datesArray[indexPath.section + 2][0] as NSDate)
                    }
                    self.eventsArray[indexPath.section + 2] = self.datesArray[indexPath.section + 2]
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
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                self.datesArray[0] = NSArray(objects: date, indexPath)
            } else {
                self.datesArray[2] = NSArray(objects: date, indexPath)
            }
        } else if indexPath.section == 2 {
            if self.daysPerWeek == 2 {
                if indexPath.row == 0 {
                    self.datesArray[1] = NSArray(objects: date, indexPath)
                } else {
                    self.datesArray[3] = NSArray(objects: date, indexPath)
                }
            } else {
                if indexPath.row == 0 {
                    self.datesArray[1] = NSArray(objects: date, indexPath)
                } else {
                    self.datesArray[4] = NSArray(objects: date, indexPath)
                }
            }
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                self.datesArray[2] = NSArray(objects: date, indexPath)
            } else {
                self.datesArray[5] = NSArray(objects: date, indexPath)
            }
        }
        
        self.tableView.reloadData()
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Add to calendar
    
    func AddToCalendar(startDate: NSObject, endDate: NSObject) -> Bool {
        var returnStatus: Bool = false
        
        if startDate as NSObject != 0 && endDate as NSObject != 0 {
            var event = EKEvent(eventStore: self.eventStore)
            var longBallCal: EKCalendar!
            var compare: NSTimeInterval = (startDate as NSDate).timeIntervalSinceDate(endDate as NSDate)
            
            if compare < 0 {
                if self.data.GetTitle() == "Weekly Routine" {
                    var repeat = EKRecurrenceRule(recurrenceWithFrequency: EKRecurrenceFrequencyWeekly, interval: 1, end: nil)
                    event.recurrenceRules = [repeat]
                }
                
                if canAddToCalendar {
                    if self.calendar == nil {
                        SetCalendar(self.eventStore)
                    }
                    
                    event.title = NSString(format: "LongBall Training: %@", self.data.GetTitle())
                    event.startDate = startDate as NSDate
                    event.endDate = endDate  as NSDate
                    event.calendar = self.calendar
                    event.addAlarm(EKAlarm(absoluteDate: startDate as NSDate))
                    self.eventStore.saveEvent(event, span: EKSpanThisEvent, error: nil)
                    
                    returnStatus = true
                } else {
                    var alert = UIAlertView(
                        title: "Unable to Add Calendar Event",
                        message: "LongBall needs to access your calendar. You can grant access by going to your device's Settings -> Privacy -> Calendars -> LongBall",
                        delegate: self,
                        cancelButtonTitle: "Okay"
                    )
                    alert.show()
                }
            } else {
                var alert = UIAlertView(
                    title: "Unable to Add Calendar Event",
                    message: "It looks like an event is ending before it starts. Double check each day's start and end times.",
                    delegate: self,
                    cancelButtonTitle: "Okay"
                )
                alert.show()
            }
        } else {
            var alert = UIAlertView(
                title: "Unable to Add Calendar Event",
                message: "It looks like a day hasn't been set. Double check each day's start and end times.",
                delegate: self,
                cancelButtonTitle: "Okay"
            )
            alert.show()
        }
        
        return returnStatus
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
