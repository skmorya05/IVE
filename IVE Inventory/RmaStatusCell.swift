//
//  RmaStatusCell.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 24/04/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

protocol StatusUpdateProtocol:class
{
    func didUpdateStatus(cell:RmaStatusCell)
}

class RmaStatusCell: UITableViewCell
{
    @IBOutlet weak var lblRma:UILabel!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblBrand:UILabel!
    
    @IBOutlet weak var lblCreatedate:UILabel!
    @IBOutlet weak var lblPhone:UILabel!
    @IBOutlet weak var lblModel:UILabel!
    
    @IBOutlet weak var lblStatus:UILabel!
    @IBOutlet weak var btnStatus:UIButton!
    
    weak var delegate:StatusUpdateProtocol!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnStatus.setTitle("Open", for: .normal)
        self.btnStatus.setTitleColor(UIColor.red, for: .normal)

        self.btnStatus.setTitle("Shipped", for: .selected)
        self.btnStatus.setTitleColor(#colorLiteral(red: 0.04837479125, green: 0.4662186503, blue: 0.1727727404, alpha: 1), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnStatusTapped(sender:UIButton)
    {
        self.delegate.didUpdateStatus(cell: self)
    }
}
