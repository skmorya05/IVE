//
//  RmaDetailCell.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 03/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class RmaDetailCell: UITableViewCell {

    @IBOutlet weak var lbl_Rma:UILabel!
    @IBOutlet weak var lbl_RmaType:UILabel!
    @IBOutlet weak var lbl_Name:UILabel!
    @IBOutlet weak var lbl_Company:UILabel!
    @IBOutlet weak var lbl_Address:UILabel!
    @IBOutlet weak var lbl_Brand:UILabel!
    @IBOutlet weak var lbl_Model:UILabel!
    @IBOutlet weak var lbl_Serial:UILabel!
    @IBOutlet weak var lbl_Order:UILabel!
    @IBOutlet weak var lbl_SalesReceipt:UILabel!
    @IBOutlet weak var lbl_PurchaseDate:UILabel!
    @IBOutlet weak var lbl_ReasonForReturn:UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
