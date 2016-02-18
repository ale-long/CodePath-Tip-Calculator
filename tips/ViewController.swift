//
//  ViewController.swift
//  tips
//
//  Created by Matthew Leonard on 2/13/16.
//  Copyright © 2016 matteleonard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var personControl: UIStepper!
    @IBOutlet weak var personCountLabel: UILabel!
    @IBOutlet weak var personTotalLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    
    let tipData = TipData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"clearBill", name:
            UIApplicationWillEnterForegroundNotification, object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        personTotalLabel.text = "$0.00"
        
        billField.center.y = 260
        billField.alpha = 0
        
        self.settingsButton.center.y = 35
        self.settingsButton.center.x = view.bounds.width + 40
        self.settingsButton.alpha = 0
        
        self.controlView.alpha = 0
        
        hideControlView()

    }
    
    func clearBill(){
        print("here")
        let defaults = NSUserDefaults.standardUserDefaults()
        print(defaults.stringForKey("billAmount"))
        if let billAmount = defaults.stringForKey("billAmount")
        {
            billField.text = billAmount
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tipControl.selectedSegmentIndex = tipData.tipindex
        
        if billField.text?.characters.count == 0 {
            billField.becomeFirstResponder();
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if billField.text!.characters.count == 0 {
            UIView.animateWithDuration(0.75, delay: 0.5, options: .CurveEaseInOut, animations: {
                self.settingsButton.center.x = self.view.bounds.width - 40
                self.settingsButton.alpha = 1
                }, completion: { (finished: Bool) in
            })
            
            showBillFieldOnly()
        }
    }
    
    func hideControlView() {
        UIView.animateWithDuration(0.75, delay: 0.5, options: .CurveEaseInOut, animations: {
            self.controlView.center.y = self.view.bounds.height
            self.controlView.alpha = 0
            
            }, completion: { (finished: Bool) in
        })
    }
    
    func showControlView() {
        UIView.animateWithDuration(0.5, delay: 0.1, options: .CurveEaseInOut, animations: {
            self.controlView.center.y = 500
            self.controlView.alpha = 1
            
            self.billField.center.y = 128
            
            }, completion: { (finished: Bool) in
        })
    }
    
    func showBillFieldOnly() {
        UIView.animateWithDuration(0.75, delay: 0.5, options: .CurveEaseInOut, animations: {
        
            self.settingsButton.center.x = self.view.bounds.width - 40
            self.settingsButton.alpha = 1
            }, completion: { (finished: Bool) in
        })
        
        
        UIView.animateWithDuration(0.75, delay: 0.75, options: .CurveEaseInOut, animations: {
            self.billField.center.y = 230
            self.billField.alpha = 1
            }, completion: { (finished: Bool) in
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func determineControlsToShow(sender: AnyObject) {
        if billField.text!.characters.count > 0 {
            showControlView()
        } else {
            showBillFieldOnly()
            hideControlView()
        }
    }
    

    @IBAction func onEditingChanged(sender: AnyObject) {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "billAmount")
        
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        let personTotal = total / personControl.value
        
        tipLabel.text = numberFormatter.stringFromNumber(tip)!
        totalLabel.text = numberFormatter.stringFromNumber(total)
        personTotalLabel.text = numberFormatter.stringFromNumber(personTotal)
        personCountLabel.text = String(Int(personControl.value))
    }
}

