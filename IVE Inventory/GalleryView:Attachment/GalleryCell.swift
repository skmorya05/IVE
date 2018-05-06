//
//  DrCardsEditPhotoCell.swift
//  TestApp
//
//  Created by sanjay on 23/11/17.
//  Copyright © 2017 sanjay. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell, UIScrollViewDelegate {

    @IBOutlet weak var scrollImageView: UIScrollView!
    @IBOutlet weak var capturedImageView: UIImageView!
        
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.scrollImageView.delegate = self
        self.scrollImageView.minimumZoomScale = 1.0
        self.scrollImageView.maximumZoomScale = 3.0
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(gestureRecognizer:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        self.capturedImageView.addGestureRecognizer(doubleTapRecognizer)
        
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onSingleTap(gestureRecognizer:)))
        singleTapRecognizer.numberOfTapsRequired = 1
        self.capturedImageView.addGestureRecognizer(singleTapRecognizer)
        
        singleTapRecognizer.require(toFail: doubleTapRecognizer)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.capturedImageView
    }
    
    @objc func onDoubleTap(gestureRecognizer: UITapGestureRecognizer)
    {
        let scale = min(scrollImageView.zoomScale * 2, scrollImageView.maximumZoomScale)
        
        if scale != scrollImageView.zoomScale
        {
            let point = gestureRecognizer.location(in: capturedImageView)
            
            let scrollSize = scrollImageView.frame.size
            let size = CGSize(width: scrollSize.width / scale,
                              height: scrollSize.height / scale)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollImageView.zoom(to:CGRect(origin: origin, size: size), animated: true)
            
            self.parentViewController?.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        else
        {
            let point = gestureRecognizer.location(in: capturedImageView)
            let size = scrollImageView.frame.size
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollImageView.zoom(to:CGRect(origin: origin, size: size), animated: true)
        }
    }
    
    @objc func onSingleTap(gestureRecognizer: UITapGestureRecognizer)
    {
        if let _ = self.parentViewController?.isKind(of: GalleryViewController.self)
        {
            if let isHidden = self.parentViewController?.navigationController?.isNavigationBarHidden, isHidden == true
            {
                self.parentViewController?.navigationController?.setNavigationBarHidden(false, animated: true)
            }
            else
            {
                self.parentViewController?.navigationController?.setNavigationBarHidden(true, animated: true)
            }
        }
    }
    
    
    var parentViewController: UIViewController? {
        
        var parentResponder: UIResponder? = self
        
        while parentResponder != nil {
            
            parentResponder = parentResponder!.next
            
            if let viewController = parentResponder as? UIViewController
            {
                return viewController
            }
        }
        return nil
    }
}


