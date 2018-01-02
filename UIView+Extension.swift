//
//  UIView+Extension.swift
//  phonebook_diro
//
//  Created by sanjay on 19/07/17.
//  Copyright © 2017 dirolabs-A1005. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    
    ///
    /// - Parameters:
    ///   - view: to make COrnor Smooth
    ///   - corners: Set of Cornors
    ///   - radius: Smoothness
    func roundCorners(view:UIView, corners:UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
        
    }
    
    // Add Shadow on view
    func addShadow()
    {
        self.layer.shadowColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.4).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = CGSize.init(width: 0.0, height: 2.0)
        self.layer.masksToBounds = false
    }
    
    
}
