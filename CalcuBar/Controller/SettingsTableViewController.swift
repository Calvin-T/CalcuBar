//
//  SettingsTableViewController.swift
//  CalcuBar
//
//  Created by Calvin Tang on 1/26/19.
//  Copyright © 2019 Calvin Tang. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard

var kgAvailability = [true, true, true, true, true, true, true, true, true, true]
var lbsAvailability = [true, true, true, true, true, true, true, true]

class SettingsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if lbsSwitches != nil {
            for i in 0..<lbsAvailability.count {
                lbsSwitches[i].setOn(lbsAvailability[i], animated: false)
            }
        }
        
        if kgSwitches != nil {
            for i in 0..<kgAvailability.count {
                kgSwitches[i].setOn(kgAvailability[i], animated: false)
            }
        }
        
    }
    
    @IBOutlet var lbsSwitches: [UISwitch]!
    @IBOutlet var kgSwitches: [UISwitch]!
    
    @IBAction func lbsSwitchChanged(_ sender: UISwitch) {
        
        lbsAvailability[sender.tag] = !lbsAvailability[sender.tag]
        defaults.set(lbsAvailability, forKey: "lbsSettingsArray")
        
    }
    
    @IBAction func kgSwitchChanged(_ sender: UISwitch) {
        
        kgAvailability[sender.tag] = !kgAvailability[sender.tag]
        defaults.set(kgAvailability, forKey: "kgSettingsArray")
        
    }
    
    
    
    
    
    
    
}
