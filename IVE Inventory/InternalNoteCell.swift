//
//  InternalNoteCell.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 03/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class InternalNoteCell: UITableViewCell {

    @IBOutlet weak var number_label: UILabel!
    @IBOutlet weak var note_label: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }
    
}
