//
//  RoundedButton.swift
//  CalcuBar
//
//  Created by Calvin Tang on 1/20/19.
//  Copyright © 2019 Calvin Tang. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    

    

}

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = 2
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = 3
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            //guard let uiColor = newValue else { return }
            layer.borderColor = UIColor.darkGray.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable override open var backgroundColor: UIColor? {
        set {
            layer.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
        } get {
            return UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        }
    }
    
}

