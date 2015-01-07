//
//  MainViewController.swift
//  LongBall
//
//  Created by Stephen Kyles on 12/24/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, SKSpeedPickerDelegate {
    let dataModel = DataModel()
    
    var allWeeks: NSArray!
    var allSpeeds: NSArray!
    var allExtras: NSArray!
    var fastestSpeed: NSString = "tap to add"
    var fastestSpeedIndex: NSInteger = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "LongBall"
        
        self.allWeeks = dataModel.GetAllWeeks()
        self.allSpeeds = dataModel.GetSwingSpeeds()
        self.allExtras = dataModel.GetExtraTitles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Speed picker delegate
    
    func GetSpeed(index: NSInteger) {
        self.fastestSpeedIndex = index
        self.fastestSpeed = NSString(format: "%@", self.allSpeeds.objectAtIndex(index) as NSString)
        self.tableView.reloadData()
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return dataModel.GetTrackingTitles().count
        } else if section == 2 {
            return dataModel.GetExtraTitles().count
        }
        return dataModel.GetNumberOfWeeks()
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Tracking"
        } else if section == 2 {
            return "Extras"
        }
        return "Training"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        if indexPath.section == 0 {
            var data = self.allWeeks.objectAtIndex(indexPath.row) as DataObject
            
            cell.textLabel?.text = data.GetTitle()
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.detailTextLabel?.text = nil
        } else if indexPath.section == 1 {
            var data = dataModel.GetTrackingTitles().objectAtIndex(indexPath.row) as NSString
            
            cell.textLabel?.text = data as NSString
            
            if indexPath.row == 0 {
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.detailTextLabel?.text = self.fastestSpeed
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                cell.detailTextLabel?.text = nil
            }
        } else {
            var data = dataModel.GetExtraTitles().objectAtIndex(indexPath.row) as NSString
            
            if indexPath.row == 0 {
                cell.accessoryType = UITableViewCellAccessoryType.None
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            }
            cell.textLabel?.text = data as NSString
            cell.detailTextLabel?.text = nil
        }
        
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            self.performSegueWithIdentifier("ShowDetail", sender: indexPath)
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                self.performSegueWithIdentifier("SwingSpeedPicker", sender: indexPath)
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                self.performSegueWithIdentifier("ShowInfo", sender: indexPath)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowDetail") {
            var indexPath = sender as NSIndexPath
            var detailView = segue.destinationViewController as DetailViewController
            
            detailView.data = self.allWeeks.objectAtIndex(indexPath.row) as DataObject
        } else if (segue.identifier == "SwingSpeedPicker") {
            var indexPath = sender as NSIndexPath
            var speedView = segue.destinationViewController as SwingSpeedViewController
            
            speedView.delegate = self
            speedView.allSpeeds = self.allSpeeds
            speedView.fastestSpeedIndex = self.fastestSpeedIndex
        }
    }
}
