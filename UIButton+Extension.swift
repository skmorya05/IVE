//
//  UIButton+Extension.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 04/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation

extension UIButton
{
    func updateButtonsUI(text:String)
    {
        self.layer.cornerRadius = 2.0
        self.clipsToBounds = true
        self.layer.borderColor = ColorConstant.navBarColor.cgColor
        self.layer.borderWidth = 2.0
        
        // .Selected
        let attr1 = NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        self.setAttributedTitle(attr1, for: .selected)
        
        // .Normal
        let attr2 = NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        self.setAttributedTitle(attr2, for: .normal)
    }
    
    func updateButtonState(isSelected:Bool)
    {
        if isSelected
        {
            self.isSelected = true
            self.backgroundColor = ColorConstant.saffroFillColor
        }
        else
        {
            self.isSelected = false
            self.backgroundColor = ColorConstant.btnBgColor
        }
    }
}
