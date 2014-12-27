//
//  PickerViewController.swift
//  LongBall
//
//  Created by Stephen Kyles on 12/26/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

import UIKit

protocol SKDatePickerDelegate {
    func GetDate(date: NSDate, indexPath: NSIndexPath)
}

class PickerViewController: UIViewController {
    var delegate: SKDatePickerDelegate! = nil
    var indexPath: NSIndexPath!
    
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var backgroundImage = UIImage(named: "background.png")
        var imageView = UIImageView(image: backgroundImage!)
        imageView.frame = view.frame
                
        let blurEffect = UIBlurEffect(style: .ExtraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = view.frame
        blurView.insertSubview(imageView, atIndex: 0)
        
        self.view.insertSubview(blurView, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack() {
        delegate!.GetDate(datePicker.date, indexPath: self.indexPath)
    }
}
