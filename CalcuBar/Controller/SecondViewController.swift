//
//  SecondViewController.swift
//  CalcuBar
//
//  Created by Calvin Tang on 1/19/19.
//  Copyright © 2019 Calvin Tang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var firstSetSide: [UIImageView]!
    @IBOutlet var secondSetSide: [UIImageView]!
    @IBOutlet var thirdSetSide: [UIImageView]!
    @IBOutlet var fourthSetSide: [UIImageView]!
    @IBOutlet var fifthSetSide: [UIImageView]!
    @IBOutlet var sixthSetSide: [UIImageView]!
    @IBOutlet var seventhSetSide: [UIImageView]!
    
    var sideSets: [[UIImageView]] = []
    
    @IBOutlet weak var totalWeightLabel: UILabel!
    @IBOutlet weak var convertedWeightLabel: UILabel!
    
    @IBOutlet weak var unitSelector: UISegmentedControl!
    
    var unit: units = .kg
    
    var platesLoaded = 0;
    
    var input: String = ""
    
    @IBOutlet weak var inputTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sideSets = [firstSetSide, secondSetSide, thirdSetSide,fourthSetSide, fifthSetSide, sixthSetSide, seventhSetSide]
    }
    
    @IBAction func unitChanged(_ sender: Any) {
        clearPlates()
        if unitSelector.selectedSegmentIndex == 0 {
            totalWeightLabel.text = "20.0\nKG"
            convertedWeightLabel.text = "44.1\nLBS"
            inputTextField.text = " |  kg"
            input = ""
            
            unit = .kg
            
        } else {
            totalWeightLabel.text = "45.0\nLBS"
            convertedWeightLabel.text = "20.4\nKG"
            inputTextField.text = " | lbs"
            input = ""
            
            unit = .lbs
        }
        
        
    }
    
    @IBAction func numPadPressed(_ sender: RoundedButton) {
        if sender.tag == 10 {
            input.append(".")
        } else {
            input.append("\(sender.tag)")
        }
        updateTextField(input: input)
    }
    
    @IBAction func backspacePressed(_ sender: Any) {
        if input.count > 0 {
            input.removeLast()
            updateTextField(input: input)
        }
    }
    
    @IBAction func clearPressed(_ sender: Any) {
        input = ""
        updateTextField(input: input)
    }
    
    @IBAction func calculate(_ sender: Any) {
        clearPlates()
        if input == "" {
            errorFillingBar(message: "Error! Please enter a weight to fill.")
            return
        }
        
        var weight = Double(input)!
        print(weight)
        
        if unit == .kg {
            
            if weight < 20 {
                errorFillingBar(message: "Error! Weight given is too light.")
            }
            
            totalWeightLabel.text = "\(weight)\nKG"
            convertedWeightLabel.text = "\(convertToLBS(kg: weight))\nLBS"
            weight -= 20
        
            while weight > 0 {
                if platesLoaded < 7 {
                    print(weight)
                    if weight >= 50 {
                        weight -= 50
                        updateBar(withImage: "25KG Side", atIndex: platesLoaded)
                    } else if weight < 50 && weight >= 40 {
                        weight -= 40
                        updateBar(withImage: "20KG Side", atIndex: platesLoaded)
                    } else if weight < 40 && weight >= 30 {
                        weight -= 30
                        updateBar(withImage: "15KG Side", atIndex: platesLoaded)
                    } else if weight < 30 && weight >= 20 {
                        weight -= 20
                        updateBar(withImage: "10KG Side", atIndex: platesLoaded)
                    } else if weight < 20 && weight >= 10 {
                        weight -= 10
                        updateBar(withImage: "5KG Side", atIndex: platesLoaded)
                    } else if weight < 10 && weight >= 5 {
                        weight -= 5
                        updateBar(withImage: "2.5KG Side", atIndex: platesLoaded)
                    } else if weight < 5 && weight >= 4 {
                        weight -= 4
                        updateBar(withImage: "2KG Side", atIndex: platesLoaded)
                    } else if weight < 4 && weight >= 3 {
                        weight -= 3
                        updateBar(withImage: "1.5KG Side", atIndex: platesLoaded)
                    } else if weight < 3 && weight >= 2 {
                        weight -= 2
                        updateBar(withImage: "1KG Side", atIndex: platesLoaded)
                    } else if weight < 2 && weight >= 1 {
                        weight -= 1
                        updateBar(withImage: "0.5KG Side", atIndex: platesLoaded)
                    } else {
                        print("Can not do this weight")
                        errorFillingBar(message: "Error! Weight not possible.")
                        return
                    }
                    platesLoaded += 1
                } else {
                    print("Too big")
                    errorFillingBar(message: "Error! Weight given exceeded maximum.")
                    return
                }
            }
            
        } else {
            
            if weight < 45 {
                errorFillingBar(message: "Error! Weight given is too light.")
            }
            
            totalWeightLabel.text = "\(weight)\nLBS"
            convertedWeightLabel.text = "\(convertToKG(lb: weight))\nKG"
            weight -= 45
            
            while weight > 0 {
                if platesLoaded < 7 {
                    print(weight)
                    if weight > 110 {
                        weight -= 110
                        updateBar(withImage: "55LB Side", atIndex: platesLoaded)
                    } else if weight < 110 && weight >= 90 {
                        weight -= 90
                        updateBar(withImage: "45LB Side", atIndex: platesLoaded)
                    } else if weight < 90 && weight >= 70 {
                        weight -= 70
                        updateBar(withImage: "35LB Side", atIndex: platesLoaded)
                    } else if weight < 70 && weight >= 50 {
                        weight -= 50
                        updateBar(withImage: "25LB Side", atIndex: platesLoaded)
                    } else if weight < 50 && weight >= 20 {
                        weight -= 20
                        updateBar(withImage: "20LB Side", atIndex: platesLoaded)
                    } else if weight < 20 && weight >= 10 {
                        weight -= 10
                        updateBar(withImage: "5LB Side", atIndex: platesLoaded)
                    } else if weight < 10 && weight >= 5 {
                        weight -= 5
                        updateBar(withImage: "2.5LB Side", atIndex: platesLoaded)
                    } else if weight < 5 && weight >= 2.5 {
                        weight -= 2.5
                        updateBar(withImage: "1.25LB Side", atIndex: platesLoaded)
                    } else {
                        print("Can not do this weight")
                        errorFillingBar(message: "Error! Weight not possible.")
                        return
                    }
                    
                    platesLoaded += 1
                } else {
                    print("Too big")
                    errorFillingBar(message: "Error! Weight given exceeded maximum.")
                    return
                }
            }
            
        }
        
    }
    
    func errorFillingBar(message: String){
        inputTextField.text = message
        input = ""
    }
    
    func updateBar(withImage image: String,atIndex index: Int){
        sideSets[index][0].image = UIImage(named: image)
        sideSets[index][1].image = UIImage(named: image)
    }
    
    func updateTextField(input: String){
        if unit == .kg {
            inputTextField.text = "\(input) |  kg"
        } else {
            inputTextField.text = "\(input) | lbs"
        }
    }
    
    func clearPlates(){
        for set in sideSets {
            for imageView in set {
                imageView.image = nil
            }
        }
        platesLoaded = 0
    }
    
}

