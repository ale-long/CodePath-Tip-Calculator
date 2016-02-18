//
//  SettingsViewController.swift
//  tips
//
//  Created by Matthew Leonard on 2/13/16.
//  Copyright © 2016 matteleonard. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var defaultTipToggle: UISegmentedControl!
    
    let tipData = TipData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        defaultTipToggle.selectedSegmentIndex = tipData.tipindex
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func updateSettings(sender: AnyObject) {
        tipData.tipindex = defaultTipToggle.selectedSegmentIndex
    }
}

