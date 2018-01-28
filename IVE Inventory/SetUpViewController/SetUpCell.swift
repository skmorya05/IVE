//
//  SetUpCell.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 14/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

protocol SwitchStatusChange:class
{
    func didChangeStatus(cell:SetUpCell, user:IVE_User)
}

class SetUpCell: UITableViewCell
{
    @IBOutlet weak var imageView_user: UIImageView!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var switch_role: UISwitch!
    
    weak var delegate: SwitchStatusChange!
         var ive_user: IVE_User!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func statusChange(sender:UISwitch)
    {
        if let _ = delegate
        {
            self.delegate.didChangeStatus(cell: self, user: self.ive_user)
        }
    }
}
