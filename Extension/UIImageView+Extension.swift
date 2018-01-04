//
//  UIImageView.swift
//  TestApp
//
//  Created by sanjay on 23/11/17.
//  Copyright © 2017 sanjay. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    func cropAsCircleWithBorder(borderColor : UIColor, strokeWidth: CGFloat)
    {
        var radius = min(self.bounds.width, self.bounds.height)
        var drawingRect : CGRect = self.bounds
        drawingRect.size.width = radius
        drawingRect.origin.x = (self.bounds.size.width - radius) / 2
        drawingRect.size.height = radius
        drawingRect.origin.y = (self.bounds.size.height - radius) / 2
        
        radius /= 2
        
        //CGRectInset(drawingRect, strokeWidth/2, strokeWidth/2)
        //UIBezierPath(roundedRect: , cornerRadius: radius)
        var path = UIBezierPath(roundedRect: drawingRect, cornerRadius: radius)
        let border = CAShapeLayer()
        border.fillColor = UIColor.clear.cgColor
        border.path = path.cgPath
        border.strokeColor = borderColor.cgColor
        border.lineWidth = strokeWidth
        self.layer.addSublayer(border)
        
        path = UIBezierPath(roundedRect: drawingRect, cornerRadius: radius)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}


