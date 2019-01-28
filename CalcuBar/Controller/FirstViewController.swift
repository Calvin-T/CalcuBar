//
//  FirstViewController.swift
//  CalcuBar
//
//  Created by Calvin Tang on 1/19/19.
//  Copyright © 2019 Calvin Tang. All rights reserved.
//

import UIKit

enum units {
    case kg
    case lbs
}

class FirstViewController: UIViewController {
    
    @IBOutlet var weightButtons: [RoundedButton]!
    
    @IBOutlet var firstSetSide: [UIImageView]!
    @IBOutlet var secondSetSide: [UIImageView]!
    @IBOutlet var thirdSetSide: [UIImageView]!
    @IBOutlet var fourthSetSide: [UIImageView]!
    @IBOutlet var fifthSetSide: [UIImageView]!
    @IBOutlet var sixthSetSide: [UIImageView]!
    @IBOutlet var seventhSetSide: [UIImageView]!
    
    var sideSets: [[UIImageView]] = []
    
    @IBOutlet weak var unitSelector: UISegmentedControl!
    
    @IBOutlet weak var totalWeightLabel: UILabel!
    @IBOutlet weak var convertedWeightLabel: UILabel!
    
    var kgWeights = [25,20,15,10,5,2.5,2,1.5,1,0.5]
    var lbWeights = [55,45,35,25,10,5,2.5,1.25]

    var platesLoaded = 0
    var totalWeight = 20.0
    var convertedWeight = 44.0
    
    var unit: units = .kg
    
    var weightsUsed: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sideSets = [firstSetSide, secondSetSide, thirdSetSide,fourthSetSide, fifthSetSide, sixthSetSide, seventhSetSide]
        
        lbsAvailability = defaults.object(forKey: "lbsSettingsArray") as? [Bool] ?? [true,true,true,true,true,true,true,true]
        kgAvailability = defaults.object(forKey: "kgSettingsArray") as? [Bool] ?? [true,true,true,true,true,true,true,true,true,true]
        
        
    }

    @IBAction func unitChanged(_ sender: Any) {
        if unitSelector.selectedSegmentIndex == 0 {
            for i in 0..<weightButtons.count {
                if i == 5 || i == 7 || i == 9 {
                    weightButtons[i].setImage(UIImage(named: "\(kgWeights[i])KG Plate"), for: .normal)
                    weightButtons[i].setTitle("\(kgWeights[i]) KG", for: .normal)
                } else {
                    weightButtons[i].setImage(UIImage(named: "\(Int(kgWeights[i]))KG Plate"), for: .normal)
                    weightButtons[i].setTitle("\(Int(kgWeights[i])) KG", for: .normal)
                }
                
            }
            
            weightButtons[8].isEnabled = true
            weightButtons[9].isEnabled = true
            
            unit = .kg
        
            
        } else {
            
            for i in 0..<lbWeights.count {
                
                if i > 5 {
                    weightButtons[i].setImage(UIImage(named: "\(lbWeights[i])LB Plate"), for: .normal)
                    weightButtons[i].setTitle("\(lbWeights[i]) LBS", for: .normal)

                } else {
                    weightButtons[i].setImage(UIImage(named: "\(Int(lbWeights[i]))LB Plate"), for: .normal)
                    weightButtons[i].setTitle("\(Int(lbWeights[i])) LBS", for: .normal)

                }
                
            }
            
            weightButtons[8].setImage(nil, for: .normal)
            weightButtons[8].setTitle(nil, for: .normal)
            weightButtons[8].isEnabled = false
            
            weightButtons[9].setImage(nil, for: .normal)
            weightButtons[9].setTitle(nil, for: .normal)
            weightButtons[9].isEnabled = false
            
            unit = .lbs
            
        }
        reset()
    }
    
    func calculatePlate(value: Double){
        if unit == .kg {
            totalWeight = totalWeight + (value * 2)
            convertedWeight = convertToLBS(kg: totalWeight)
        } else {
            totalWeight = totalWeight + (value * 2)
            convertedWeight = convertToKG(lb: totalWeight)
        }
        weightsUsed.append(value)
        weightsUsed.sort(by: >)
        barSorted()
        //print(weightsUsed)
        //updateBarImage(withWeight: value)
    }
    
    func barSorted(){
        for i in 0..<weightsUsed.count {
            var image = ""
            let value = weightsUsed[i]
            if floor(value) == value {
                //Has no decimal value
                if unit == .kg {
                    image = "\(Int(value))KG Side"
                } else {
                    image = "\(Int(value))LB Side"
                }
            } else {
                //Has a decimal value
                if unit == .kg {
                    image = "\(value)KG Side"
                } else {
                    image = "\(value)LB Side"
                }
            }
            sideSets[i][0].image = UIImage(named: image)
            sideSets[i][1].image = UIImage(named: image)
            
        }
    }
    
    @IBAction func addPlate(_ sender: RoundedButton) {
        if platesLoaded < 7 {
            if unit == .kg {
                switch sender.tag {
                case 0:
                    calculatePlate(value: 25)
                case 1:
                    calculatePlate(value: 20)
                case 2:
                    calculatePlate(value: 15)
                case 3:
                    calculatePlate(value: 10)
                case 4:
                    calculatePlate(value: 5)
                case 5:
                    calculatePlate(value: 2.5)
                case 6:
                    calculatePlate(value: 2)
                case 7:
                    calculatePlate(value: 1.5)
                case 8:
                    calculatePlate(value: 1)
                case 9:
                    calculatePlate(value: 0.5)
                default:
                    print("Error adding plate")
                }
                totalWeightLabel.text = "\(totalWeight)\nKG"
                convertedWeightLabel.text = "\(convertedWeight)\nLBS"
            } else {
                //print(sender.tag)
                switch sender.tag {
                case 0:
                    calculatePlate(value: 55)
                case 1:
                    calculatePlate(value: 45)
                case 2:
                    calculatePlate(value: 35)
                case 3:
                    calculatePlate(value: 25)
                case 4:
                    calculatePlate(value: 10)
                case 5:
                    calculatePlate(value: 5)
                case 6:
                    calculatePlate(value: 2.5)
                case 7:
                    calculatePlate(value: 1.25)
                default:
                    print("Error adding plate")
                }
                totalWeightLabel.text = "\(totalWeight)\nLBS"
                convertedWeightLabel.text = "\(convertedWeight)\nKG"
            }
            platesLoaded += 1
            //print("Plates: \(platesLoaded)")
            
        } else {
            //print("bar full")
        }
    }
    
    @IBAction func clearButton(_ sender: Any) {
        reset()
    }
    
    @IBAction func backspaceButton(_ sender: Any) {
        if platesLoaded > 0 {
            
            let lastWeightUsed = weightsUsed[platesLoaded-1]
            
            totalWeight = totalWeight - (2 * lastWeightUsed)
            
            if unit == .kg {
                convertedWeight = convertToLBS(kg: totalWeight)
                totalWeightLabel.text = "\(totalWeight)\nKG"
                convertedWeightLabel.text = "\(convertedWeight)\nLBS"
            } else {
                convertedWeight = convertToKG(lb: totalWeight)
                totalWeightLabel.text = "\(totalWeight)\nLBS"
                convertedWeightLabel.text = "\(convertedWeight)\nKG"
            }
            
            sideSets[platesLoaded-1][0].image = nil
            sideSets[platesLoaded-1][1].image = nil

            platesLoaded -= 1
            weightsUsed.removeLast()
            
        }
    }
    
    func clearPlateImages(){
        for set in sideSets {
            for imageView in set {
                imageView.image = nil
            }
        }
    }
    
    func reset() {
        clearPlateImages()
        platesLoaded = 0
        weightsUsed = []
        if unit == .kg {
            totalWeight = 20
            convertedWeight = 45
            totalWeightLabel.text = "20.0\nKG"
            convertedWeightLabel.text = "44.1\nLBS"
        } else {
            totalWeight = 45
            convertedWeight = 20
            totalWeightLabel.text = "45.0\nLBS"
            convertedWeightLabel.text = "20.4\nKG"
        }
    }
    
}

extension UIViewController {
    
    func convertToKG(lb: Double) -> Double {
        return Double(round(lb * 0.453592 * 10)/10)
    }
    
    func convertToLBS(kg: Double) -> Double {
        return Double(round(kg * 2.2046 * 10)/10)
    }
}
