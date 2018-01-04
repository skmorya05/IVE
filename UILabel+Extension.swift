//
//  UILabel+Extension.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 04/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation
import UIKit

extension UILabel
{
    override open func awakeFromNib()
    {
        super.awakeFromNib()
        self.setup()
    }
    
    func setup()
    {
        self.font = UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)!*DrConstants.kSCALE_FACTOR)
    }
}


