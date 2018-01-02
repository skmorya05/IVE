//
//  CGFloat+Extension.swift
//  TestApp
//
//  Created by sanjay on 23/11/17.
//  Copyright © 2017 sanjay. All rights reserved.
//

import Foundation
import UIKit
extension CGFloat
{
    func scaleFactor() -> CGFloat
    {
        let screenRect:CGRect = UIScreen.main.bounds
        let screenWidth:CGFloat = screenRect.size.width
        let scalefactor:CGFloat!
       
        scalefactor = screenWidth / 375.0
       
        return scalefactor
    }
}

