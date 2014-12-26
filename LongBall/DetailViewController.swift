//
//  ViewController.swift
//  LongBall
//
//  Created by Stephen Kyles on 12/24/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    var data: DataObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = data.GetTitle()
        
        var backbutton = UIBarButtonItem(image: UIImage(named: "back"), style: .Plain, target: self, action: "goBack")
        navigationItem.leftBarButtonItem = backbutton
        
        var schedulebutton = UIBarButtonItem(image: UIImage(named: "schedule"), style: .Plain, target: self, action: "GoToSchedule")
        navigationItem.rightBarButtonItem = schedulebutton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func goBack() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func GoToSchedule() {
        self.performSegueWithIdentifier("ShowSchedule", sender: self)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0 {
            return 2
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Duration"
        } else if section == 1 {
            return "Overspeed"
        }
        return "Overspeed & Weighted"
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        return "After completing these sets with your normal dexterity, switch to your opposite dexerity and complete the sets again."
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "Days Per Week:"
            cell.detailTextLabel?.text = data.GetDaysPerWeek()
        } else if indexPath.section == 1 && indexPath.row == 0 {
            cell.textLabel?.text = "Sets:"
            cell.detailTextLabel?.text = data.GetOverspeedSets()
        } else if indexPath.section == 1 && indexPath.row == 1 {
            cell.textLabel?.text = "Reps:"
            cell.detailTextLabel?.text = data.GetOverspeedReps()
        } else if indexPath.section == 2 && indexPath.row == 0 {
            cell.textLabel?.text = "Sets:"
            cell.detailTextLabel?.text = data.GetWeightedSets()
        } else {
            cell.textLabel?.text = "Reps:"
            cell.detailTextLabel?.text = data.GetWeightedReps()
        }
        
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowSchedule") {
            var nav = segue.destinationViewController as UINavigationController
            var scheduleView = nav.viewControllers[0] as ScheduleTableViewController
            
            scheduleView.data = self.data
        }
    }
}

