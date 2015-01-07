//
//  InfoViewController.swift
//  LongBall
//
//  Created by Stephen Kyles on 12/27/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {    
    @IBOutlet weak var textView: UITextView!

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
        
        //textView.text = "about text"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
