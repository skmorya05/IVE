//
//  VendorsCell.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 23/04/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class VendorsCell: UITableViewCell {

    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblEmail:UILabel!
    @IBOutlet weak var lblPhone:UILabel!
    @IBOutlet weak var lblOpen:UILabel!
    @IBOutlet weak var lblShipped:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblOpen.layer.cornerRadius = 5.0
        self.lblOpen.clipsToBounds = true
        
        self.lblShipped.layer.cornerRadius = 5.0
        self.lblShipped.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
