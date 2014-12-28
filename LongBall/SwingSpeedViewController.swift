//
//  SwingSpeedViewController.swift
//  LongBall
//
//  Created by Stephen Kyles on 12/27/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

import UIKit

protocol SKSpeedPickerDelegate {
    func GetSpeed(index: NSInteger)
}

class SwingSpeedViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var delegate: SKSpeedPickerDelegate! = nil
    var allSpeeds: NSArray!
    var fastestSpeedIndex: NSInteger!
    
    @IBOutlet weak var speedPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var backgroundImage = UIImage(named: "speedBackground.png")
        var imageView = UIImageView(image: backgroundImage!)
        imageView.frame = view.frame
        
        let blurEffect = UIBlurEffect(style: .ExtraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = view.frame
        blurView.insertSubview(imageView, atIndex: 0)
        
        self.view.insertSubview(blurView, atIndex: 0)
        
        self.speedPicker.delegate = self
        self.speedPicker.dataSource = self
        self.speedPicker.selectRow(self.fastestSpeedIndex > 0 ? self.fastestSpeedIndex : 0, inComponent: 0, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack() {
        delegate!.GetSpeed(speedPicker.selectedRowInComponent(0))
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.allSpeeds.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return NSString(format: "%@", self.allSpeeds.objectAtIndex(row) as NSString)
    }
}
