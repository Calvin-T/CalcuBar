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
            for lbsSwitch in lbsSwitches {
                lbsSwitch.isOn = lbsAvailability[lbsSwitch.tag]
            }
        }
        
        if kgSwitches != nil {
            for kgSwitch in kgSwitches {
                kgSwitch.isOn = kgAvailability[kgSwitch.tag]
            }
        }
        
    }
    
    @IBOutlet var lbsSwitches: [UISwitch]!
    @IBOutlet var kgSwitches: [UISwitch]!
    
    @IBAction func lbsSwitchChanged(_ sender: UISwitch) {
        
        lbsAvailability[sender.tag] = !lbsAvailability[sender.tag]
        defaults.set(lbsAvailability, forKey: "lbsSettingsArray")
        
        print("CAHNGED: \(lbsAvailability)")
        
    }
    
    @IBAction func kgSwitchChanged(_ sender: UISwitch) {
        
        kgAvailability[sender.tag] = !kgAvailability[sender.tag]
        defaults.set(kgAvailability, forKey: "kgSettingsArray")
        
    }
    
    
    
    
    
    
    
}
