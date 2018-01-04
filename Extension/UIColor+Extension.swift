//
//  UIColor+Extension.swift
//  phonebook_diro
//
//  Created by sanjay on 22/07/17.
//  Copyright © 2017 dirolabs-A1005. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func hexStringToUIColor(hex:String) -> UIColor
    {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#"))
        {
            cString = String(cString.suffix(6))
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func getColorWithRGB(color:[CGFloat]) -> UIColor
    {
        let red:CGFloat = color[0]
        let green:CGFloat = color[1]
        let blue:CGFloat = color[2]
        
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    
}
