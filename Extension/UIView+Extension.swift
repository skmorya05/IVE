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
    ///   - radius: Smoothness  //corners: [.topRight]
    func roundCorners(corners:UIRectCorner, radius: CGFloat)
    {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func roundCorners(radius: CGFloat, width:CGFloat = 0, color:UIColor = UIColor.clear)
    {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
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
    
    
    func addUpperRightHalfOfTickButton()
    {
        /*
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint.init(x: 50.0, y: 0.0))
        path.addLine(to: CGPoint.init(x: 50.0, y: 50.0))
        path.close()
        
        tickLayer.path = path.cgPath
        tickLayer.fillColor = UIColor.clear.cgColor
        self.tickBtnContainer.layer.addSublayer(tickLayer)
       */
    }
    
    func addHorizontalGradientColor(leftColor:UIColor, and rightColor:UIColor)
    {
        let gradientLayer = CAGradientLayer()
        let size = self.bounds.size
        let origin = self.bounds.origin
        gradientLayer.frame = CGRect.init(x: origin.x, y: origin.y, width: ScreenSize.SCREEN_WIDTH, height: size.height)
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.addSublayer(gradientLayer)

    }
    
}
