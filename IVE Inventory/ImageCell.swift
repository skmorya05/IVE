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

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var capturedImageView: UIImageView!
    var delgate_ImageSave:ImageSaveProtocol!

    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    @IBAction func crossButtonTapped(sender:UIButton)
    {
        if let _ = self.delgate_ImageSave
        {
            self.delgate_ImageSave.didDeleteImageFromCamera(cell: self)
        }
    }
    
}
