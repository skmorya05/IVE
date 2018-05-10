//
//  DataSource_ViewController.swift
//  CollectionView
//
//  Created by Er Sanjay Morya on 25/04/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation
import UIKit

class DataSource_ViewController: NSObject
{
    var photosArr: [[String: String]]!
}
extension DataSource_ViewController: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return photosArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        
        let photo_dict = self.photosArr[indexPath.section]
        if var image_name = photo_dict["image_name"]
        {
            image_name = "\(DrConstants.kBaseUrlImage)\(image_name)"
            if let url = URL.init(string: image_name)
            {
               cell.capturedImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "electronics"))
            }
        }
        return cell
    }
}
