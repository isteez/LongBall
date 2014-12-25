//
//  MainViewController.swift
//  LongBall
//
//  Created by Stephen Kyles on 12/24/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    let dataModel = DataModel()
    
    var allWeeks: NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "LongBall"
        
        var schedulebutton = UIBarButtonItem(image: UIImage(named: "schedule"), style: .Plain, target: self, action: "GoToSchedule")
        navigationItem.rightBarButtonItem = schedulebutton
        
        self.allWeeks = dataModel.GetAllWeeks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func GoToSchedule() {
        self.performSegueWithIdentifier("ShowSchedule", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.GetNumberOfWeeks()
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Training"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        var data = self.allWeeks.objectAtIndex(indexPath.row) as DataObject
        
        cell.textLabel?.text = data.GetTitle()
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("ShowDetail", sender: indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowDetail") {
            var indexPath = sender as NSIndexPath
            var detailView = segue.destinationViewController as DetailViewController
            
            detailView.data = self.allWeeks.objectAtIndex(indexPath.row) as DataObject
        }
        else if (segue.identifier == "ShowSchedule") {
            var scheduleView = segue.destinationViewController as ScheduleTableViewController
            
            scheduleView.allWeeks = self.allWeeks
        }
    }
}
