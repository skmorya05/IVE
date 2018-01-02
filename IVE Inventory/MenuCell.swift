//
//  DrCardsEditPhotoCell.swift
//  TestApp
//
//  Created by sanjay on 23/11/17.
//  Copyright © 2017 sanjay. All rights reserved.
//

import UIKit

class DrCardsEditPhotoCell: UICollectionViewCell {

    @IBOutlet weak var dpImageView : UIImageView!
    @IBOutlet weak var lbl_cardIcon : UILabel!
    @IBOutlet weak var lbl_cardName : UILabel!
    @IBOutlet weak var tickBtnContainer : UIView!
    @IBOutlet weak var tickBtn : UIButton!
    
    let tickLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.addShadow()
       
        addUpperRightHalfOfTickButton()
        dpImageView.layer.cornerRadius = floor(dpImageView.layer.frame.size.width*DrConstants.kSCALE_FACTOR)/2
        lbl_cardName.font = UIFont.init(name: FontConstant.SFUI_TEXT_MEDIUM, size: floor(13*DrConstants.kSCALE_FACTOR))
    }
    
   
    
    func changeColor(color:UIColor)
    {
        tickLayer.fillColor = color.cgColor
        
        dpImageView.layer.cornerRadius = floor(dpImageView.layer.frame.size.width*DrConstants.kSCALE_FACTOR)/2
        dpImageView.layer.borderWidth = 1.5
        dpImageView.layer.borderColor = color.cgColor
       // dpImageView.layer.backgroundColor = color.cgColor
        dpImageView.clipsToBounds = true
       // self.dpImageView.cropAsCircleWithBorder(borderColor: UIColor.white, strokeWidth: 2.0)
    }
    
}
