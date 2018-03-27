//
//  ImageCell.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 28/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

protocol ImageSaveProtocol: class
{
    func didDeleteImageFromCamera(cell:ImageCell)
}

class ImageCell: UICollectionViewCell, UIScrollViewDelegate
{
    @IBOutlet weak var scrollImageView: UIScrollView!
    @IBOutlet weak var capturedImageView: UIImageView!
    
    @IBOutlet weak var cancelButton: UIButton!
    var delgate_ImageSave:ImageSaveProtocol!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.scrollImageView.delegate = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(gestureRecognizer:)))
        tapRecognizer.numberOfTapsRequired = 2
        self.capturedImageView.addGestureRecognizer(tapRecognizer)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.capturedImageView
    }
    
    @objc func onDoubleTap(gestureRecognizer: UITapGestureRecognizer)
    {
        let scale = min(scrollImageView.zoomScale * 2, scrollImageView.maximumZoomScale)
        
        if scale != scrollImageView.zoomScale {
            let point = gestureRecognizer.location(in: capturedImageView)
            
            let scrollSize = scrollImageView.frame.size
            let size = CGSize(width: scrollSize.width / scale,
                              height: scrollSize.height / scale)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollImageView.zoom(to:CGRect(origin: origin, size: size), animated: true)
            print(CGRect(origin: origin, size: size))
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
    
    @IBAction func crossButtonTapped(sender:UIButton)
    {
        if let _ = self.delgate_ImageSave
        {
            self.delgate_ImageSave.didDeleteImageFromCamera(cell: self)
        }
    }
    
}
