//
//  CustomerView.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 01/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class CustomerView: UIView
{
    @IBOutlet weak var btn_Exchanged: UIButton!
    @IBOutlet weak var btn_Refend: UIButton!
    @IBOutlet weak var btn_Pending: UIButton!
    @IBOutlet weak var btn_Save: UIButton!
    
    @IBOutlet weak var btn_InternalNotes: UIButton!

    override func awakeFromNib()
    {
        if #available(iOS 11.0, *)
        {
            btn_Exchanged.roundCorners(radius: 3.0, width: 1.5, color:UIColor.init(named: "btn_borderColor")!)
            btn_Refend.roundCorners(radius: 3.0, width: 1.5, color:UIColor.init(named: "btn_borderColor")!)
            btn_Pending.roundCorners(radius: 3.0, width: 1.5, color:UIColor.init(named: "btn_borderColor")!)
            btn_Save.roundCorners(radius: 3.0, width: 1.5, color:UIColor.init(named: "btn_borderColor")!)
        }
        else
        {
            btn_Exchanged.roundCorners(radius: 3.0, width: 1.5, color:border_Color)
            btn_Refend.roundCorners(radius: 3.0, width: 1.5, color:border_Color)
            btn_Pending.roundCorners(radius: 3.0, width: 1.5, color:border_Color)
            btn_Save.roundCorners(radius: 3.0, width: 1.5, color:border_Color)
        }
        
        self.updateButtonView(senders: [btn_Exchanged, btn_Refend, btn_Pending, btn_Save])
        self.btn_Save.isHidden = true
        
        btn_Exchanged.updateButtonsUI(text: "Exchange")
        btn_Refend.updateButtonsUI(text: "Need to Refund")
        btn_Pending.updateButtonsUI(text: "Pending")
    }
    
    func updateButtonView(senders:[UIButton])
    {
        for btn in senders
        {
            btn.contentHorizontalAlignment = .center
            btn.titleLabel?.textAlignment = .center
            btn.titleLabel?.numberOfLines = 0
            btn.setTitleColor(border_Color, for: .normal)
        }
    }
    
    @IBAction func btn_Tapped_Exchanged(sender:UIButton)
    {
        self.btn_Save.isHidden = false
        self.btn_Exchanged.updateButtonState(isSelected: true)
        self.btn_Refend.updateButtonState(isSelected: false)
        self.btn_Pending.updateButtonState(isSelected: false)
    }
    @IBAction func btn_Tapped_Refend(sender:UIButton)
    {
        self.btn_Save.isHidden = false
        self.btn_Exchanged.updateButtonState(isSelected: false)
        self.btn_Refend.updateButtonState(isSelected: true)
        self.btn_Pending.updateButtonState(isSelected: false)
    }
    @IBAction func btn_Tapped_Pending(sender:UIButton)
    {
        self.btn_Save.isHidden = false
        self.btn_Exchanged.updateButtonState(isSelected: false)
        self.btn_Refend.updateButtonState(isSelected: false)
        self.btn_Pending.updateButtonState(isSelected: true)
    }
}
