//
//  PickerViewController.swift
//  LongBall
//
//  Created by Stephen Kyles on 12/24/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var allWeeks: NSArray!

    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Schedule"
        self.view.backgroundColor = .clearColor()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        let blurEffect = UIBlurEffect(style: .ExtraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = view.frame
        view.insertSubview(blurView, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.allWeeks.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.allWeeks.objectAtIndex(row) as NSString
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
