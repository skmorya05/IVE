//
//  UIBarButtonItem+Extension.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 25/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import Foundation
import  UIKit

extension UIBarButtonItem
{
    public class func itemWith(colorfulImage: UIImage?, target: AnyObject, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(colorfulImage, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 25.0, height: 25.0)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}
