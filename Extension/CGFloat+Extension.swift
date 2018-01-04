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
    /*func scaleFactor() -> CGFloat
    {
        let screenRect:CGRect = UIScreen.main.bounds
        let screenWidth:CGFloat = screenRect.size.width
        let scalefactor:CGFloat!
       
        scalefactor = screenWidth / 375.0
       
        return scalefactor
    }*/
    
    func scaleFactor() -> CGFloat
    {
        let screenRect:CGRect = UIScreen.main.bounds
        let screenHeight:CGFloat = screenRect.size.height
        let scalefactor:CGFloat!
        scalefactor = screenHeight / 667.0
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            return scalefactor
        }
        else
        {
            return scalefactor < 1.3 ? scalefactor:1.3
        }
    }
}

