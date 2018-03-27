//
//  InventoryView.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 02/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

let border_Color = UIColor.init(red: 0.686, green: 0.686, blue: 0.682, alpha: 1.0)

class InventoryView: UIView
{
    @IBOutlet weak var height_Container: NSLayoutConstraint!
    @IBOutlet weak var container_view: UIView!
    @IBOutlet weak var stack_view: UIStackView!
    
    @IBOutlet weak var btn_ResaleAsUsed: UIButton!
    @IBOutlet weak var btn_ResaleAsNew: UIButton!
    @IBOutlet weak var btn_DefectiveNotWorking: UIButton!
    
    @IBOutlet weak var btn_unknownVendor: UIButton!
    @IBOutlet weak var btn_notReturnToVendor: UIButton!
    @IBOutlet weak var btn_ReturnToVendor: UIButton!
    
    @IBOutlet weak var lbl_unknownVendor: UILabel!
    @IBOutlet weak var lbl_notReturnToVendor: UILabel!
    @IBOutlet weak var lbl_ReturnToVendor: UILabel!
    
    @IBOutlet weak var btn_selectVendor: UIButton!
    @IBOutlet weak var btn_save: UIButton!
    @IBOutlet weak var btn_InternalNotes: UIButton!
    
    weak var vcObject: DetailsViewController!

    override func awakeFromNib()
    {
        if #available(iOS 11.0, *)
        {
            btn_ResaleAsUsed.roundCorners(radius: 3.0, width: 1.5, color:UIColor.init(named: "btn_borderColor")!)
            btn_ResaleAsNew.roundCorners(radius: 3.0, width: 1.5, color:UIColor.init(named: "btn_borderColor")!)
            btn_DefectiveNotWorking.roundCorners(radius: 3.0, width: 1.5, color:UIColor.init(named: "btn_borderColor")!)
            btn_save.roundCorners(radius: 3.0, width: 1.5, color:UIColor.init(named: "btn_borderColor")!)
        }
        else
        {
            btn_ResaleAsUsed.roundCorners(radius: 3.0, width: 1.5, color:border_Color)
            btn_ResaleAsNew.roundCorners(radius: 3.0, width: 1.5, color:border_Color)
            btn_DefectiveNotWorking.roundCorners(radius: 3.0, width: 1.5, color:border_Color)
            btn_save.roundCorners(radius: 3.0, width: 1.5, color:border_Color)
        }
        
        self.updateButtonView(senders: [btn_ResaleAsUsed, btn_ResaleAsNew, btn_DefectiveNotWorking, btn_save])
        self.btn_selectVendor.roundCorners(corners: .allCorners, radius: 1.5)
        self.btn_save.roundCorners(corners: .allCorners, radius: 1.5)

        
        self.btn_selectVendor.isHidden = true
        self.btn_save.isHidden = true
        
        self.btn_ResaleAsUsed.updateButtonsUI(text: "Resale As Used")
        self.btn_ResaleAsNew.updateButtonsUI(text: "Resale As New")
        self.btn_DefectiveNotWorking.updateButtonsUI(text: "Defective Not Working")
        
        self.showRadioButtons(isShow: true)
        self.height_Container.constant =  93.0
        self.layoutSubviews()
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
    
    @IBAction func btn_Tapped_ResaleAsUsed(sender:UIButton)
    {
        self.btn_save.isHidden = false
        self.btn_ResaleAsUsed.updateButtonState(isSelected: true)
        self.btn_ResaleAsNew.updateButtonState(isSelected: false)
        self.btn_DefectiveNotWorking.updateButtonState(isSelected: false)
        
        self.btn_selectVendor.isHidden = true
        self.showRadioButtons(isShow: true)
    }
    @IBAction func btn_Tapped_ResaleAsNew(sender:UIButton)
    {
        self.btn_save.isHidden = false
        self.btn_ResaleAsUsed.updateButtonState(isSelected: false)
        self.btn_ResaleAsNew.updateButtonState(isSelected: true)
        self.btn_DefectiveNotWorking.updateButtonState(isSelected: false)
        
        self.btn_selectVendor.isHidden = true
        self.showRadioButtons(isShow: true)
    }
    @IBAction func btn_Tapped_DefectiveNotWorking(sender:UIButton)
    {
        self.btn_save.isHidden = false
        self.btn_ResaleAsUsed.updateButtonState(isSelected: false)
        self.btn_ResaleAsNew.updateButtonState(isSelected: false)
        self.btn_DefectiveNotWorking.updateButtonState(isSelected: true)
        
        self.showRadioButtons(isShow: false)
        
        if self.btn_ReturnToVendor.isSelected == true
        {
            self.btn_selectVendor.isHidden = false
        }
        else
        {
            self.btn_selectVendor.isHidden = true
        }
    }
    
    //MARK: - Action On Radio Buttons
    @IBAction func btn_Tapped_unknownVendor(sender:UIButton)
    {
        self.btn_unknownVendor.isSelected = true
        self.btn_notReturnToVendor.isSelected = false
        self.btn_ReturnToVendor.isSelected = false
        
        self.btn_selectVendor.isHidden = true
    }
    
    @IBAction func btn_Tapped_notReturnToVendor(sender:UIButton)
    {
        self.btn_unknownVendor.isSelected = false
        self.btn_notReturnToVendor.isSelected = true
        self.btn_ReturnToVendor.isSelected = false
        
        self.btn_selectVendor.isHidden = true
    }
    
    @IBAction func btn_Tapped_ReturnToVendor(sender:UIButton)
    {
        self.btn_unknownVendor.isSelected = false
        self.btn_notReturnToVendor.isSelected = false
        self.btn_ReturnToVendor.isSelected = true
        self.btn_selectVendor.isHidden = false
    }
    
    func showRadioButtons(isShow:Bool)
    {
        if isShow == true
        {
            self.showLabels(isHidden:true)
            UIView.animate(withDuration: 1.5, animations: {
                self.height_Container.constant =  93.0
            }, completion: nil)
        }
        else
        {
            UIView.animate(withDuration: 1.5, animations: {
                self.height_Container.constant =   270.0
            }, completion: { _ in
                self.showLabels(isHidden:false)
            })
        }
    }
    
    func showLabels(isHidden:Bool)
    {
        self.lbl_unknownVendor.isHidden = isHidden
        self.lbl_notReturnToVendor.isHidden = isHidden
        self.lbl_ReturnToVendor.isHidden = isHidden
        
        self.btn_unknownVendor.isHidden = isHidden
        self.btn_notReturnToVendor.isHidden = isHidden
        self.btn_ReturnToVendor.isHidden = isHidden
    }
    
    //MARK:- Action Select Vendors
    @IBAction func btn_Tapped_selectVendor(sender:UIButton)
    {
       //Webservice hit then load pickerview page
       /* NetworkManager.sharedManager.getVendorsList { (vendorsList) in
            
            if let _ = vendorsList
            {
                let vc = VendorSelectionVC.init(nibName: "VendorSelectionVC", bundle: nil)
                vc.vendors = vendorsList
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.vcObject.present(vc, animated: true, completion: nil)
            }
        } */
    }
}
