//
//  InventoryReceiptCell.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 08/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class InventoryReceiptCell: UITableViewCell
{
    @IBOutlet weak var img_IRReceipt: UIImageView!
    
    @IBOutlet weak var lbl_Ir: UILabel!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_CreateDate: UILabel!
    
    @IBOutlet weak var btn_PriceOk: UIButton!
    @IBOutlet weak var btn_ReceivedQB: UIButton!
    @IBOutlet weak var btn_InvoicePaid: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
