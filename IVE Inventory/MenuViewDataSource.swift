//
//  DrCardsEditPhotoDataSource.swift
//  TestApp
//
//  Created by sanjay on 23/11/17.
//  Copyright © 2017 sanjay. All rights reserved.
//

import Foundation
import UIKit

class MenuViewDataSource: NSObject {
    var menuArray : [String]!
}

extension MenuViewDataSource: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 1
        }
        else
        {
            return menuArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        var headerReusableview = UICollectionReusableView()
        
        if (kind == UICollectionElementKindSectionHeader && indexPath.section == 1)
        {
            headerReusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as!  HeaderView
            headerReusableview.backgroundColor  = UIColor.hexStringToUIColor(hex: "#E6E7E9")
        }
        
        return headerReusableview
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if indexPath.section == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuMainCell", for: indexPath) as! MenuMainCell
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.dpImageView.image = UIImage.init(named: menuArray[indexPath.row])
        cell.lbl_cardName.text = menuArray[indexPath.row]
        
        
        return cell
    }
}
