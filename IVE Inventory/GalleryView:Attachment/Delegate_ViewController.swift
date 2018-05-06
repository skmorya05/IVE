//
//  Delegate_ViewController.swift
//  CollectionView
//
//  Created by Er Sanjay Morya on 25/04/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation
import UIKit

protocol UpdateCurrentPageProtocol:class {
    func didUpdateCurrentPage(pageNumber:Int)
}

class Delegate_ViewController: NSObject
{
    var photosArr: [[String: String]]!
    var cellSize: CGSize!
    var delegate: UpdateCurrentPageProtocol!
}
extension Delegate_ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10.0
    }

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        
        if let _ = self.delegate
        {
            self.delegate.didUpdateCurrentPage(pageNumber: Int(currentPage))
        }
    }
}
