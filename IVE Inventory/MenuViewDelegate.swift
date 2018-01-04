//
//  DrCardsEditPhotoDelegate.swift
//  TestApp
//
//  Created by sanjay on 23/11/17.
//  Copyright © 2017 sanjay. All rights reserved.
//

import Foundation
import UIKit
protocol MenuSelectionProtocol:class {
    func didSelectMenuButton(indexPath:IndexPath)
}

class MenuViewDelegate: NSObject {
    var menuArray : [String]!
    var menuBtnDelegate:MenuSelectionProtocol!
}

extension MenuViewDelegate: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if indexPath.section == 0
        {
            return CGSize.init(width: ScreenSize.SCREEN_WIDTH , height: 149.0*DrConstants.kSCALE_FACTOR)
        }
        
        let width:CGFloat = 165.0
        let height:CGFloat = 149.0
        let scaleFacetor = CGFloat().scaleFactor()
        let size = CGSize.init(width: floor(width*scaleFacetor), height: floor(height*scaleFacetor))
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        if section == 1
        {
           return CGSize.init(width: ScreenSize.SCREEN_WIDTH, height: 10)
        }
        
        return CGSize.zero
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        if section == 1
        {
            let width:CGFloat = 165.0
            let scaleFacetor = CGFloat().scaleFactor()
            
            let edge = (ScreenSize.SCREEN_WIDTH -  (2*width*scaleFacetor))/3
            return UIEdgeInsets.init(top: 10, left: edge, bottom: 10, right: edge)
            
        }
        
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.row == 1
        {
            if let _ = self.menuBtnDelegate
            {
                self.menuBtnDelegate.didSelectMenuButton(indexPath: indexPath)
            }
        }
    }
    
}
