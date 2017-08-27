//
//  UIColor+Extension.swift
//  ThreatNet
//
//  Created by Admin on 03/02/2017.
//  Copyright © 2017 Baron Services Inc. All rights reserved.
//
import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    public class var wrong: UIColor {
        get {
            return UIColor(hexString: "FF8686")
        }
    }
    
    public class var correct: UIColor {
        get {
            return UIColor(hexString: "8CC252")
        }
    }
    
    public class var skip: UIColor {
        get {
            return UIColor(hexString: "56667D")
        }
    }
    
    public class var blueBackground: UIColor {
        get {
            return UIColor(red:0.36, green:0.61, blue:0.93, alpha:1.0)
        }
    }
    
    public class var varianTextColor: UIColor {
        get {
            return UIColor(hexString: "333333")
        }
    }
    
    public class var hintTextColor: UIColor {
        get {
            return UIColor(hexString: "8DBAF3")
        }
    }
}
