//
//  HeaderView.swift
//  phonebook_diro
//
//  Created by sanjay on 24/08/17.
//  Copyright © 2017 dirolabs-A1005. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addHorizontalGradientColor(leftColor: ColorConstant.leftRedColor, and: ColorConstant.rightRedColor)
    }
    
}
