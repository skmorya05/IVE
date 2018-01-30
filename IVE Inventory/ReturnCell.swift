//
//  ReturnCell.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 24/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit

protocol RadioButtonProtocol:class {
      func didSelectRadioButton(cell:ReturnCell)
}

class ReturnCell: UITableViewCell {

    @IBOutlet weak var lbl_rma:UILabel!
    @IBOutlet weak var lbl_serial:UILabel!
    @IBOutlet weak var lbl_brand:UILabel!
    @IBOutlet weak var lbl_model:UILabel!
    @IBOutlet weak var imgView_Status:UIImageView!
    @IBOutlet weak var lbl_name:UILabel!
    @IBOutlet weak var lbl_createdate:UILabel!
    @IBOutlet weak var lbl_reason:UILabel!
    @IBOutlet weak var btn_Radio:UIButton!
    
    var radioButtonDelegate:RadioButtonProtocol!
    var dataStruct: Return!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btn_Radio.setImage(UIImage.init(named: "radiobutton_Unselected"), for: .normal)
        self.btn_Radio.setImage(UIImage.init(named: "radiobutton_Selected"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func radioButtonTapped(sender:UIButton)
    {
        if btn_Radio.isSelected == true
        {
            btn_Radio.isSelected = false
        }
        else
        {
            btn_Radio.isSelected = true
        }
        
        if let _ = radioButtonDelegate
        {
            self.radioButtonDelegate.didSelectRadioButton(cell: self)
        }
    }
    
}
