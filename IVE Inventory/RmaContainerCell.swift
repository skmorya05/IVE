//
//  RmaContainerCell.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 03/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class RmaContainerCell: UITableViewCell, VendorSelectionProtocol
{
    @IBOutlet weak var view_container: UIView!
    var views: [UIView]!
    var rmaStruct: Return!
    var cusView: CustomerView!
    var invView: InventoryView!
    var vendorName: String!
    
    weak var delegate_InternalProtocol: InternalProtocols!
    weak var vcObject: DetailsViewController!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    func configureView()
    {
         self.views = [UIView]()
       
        self.view_container.frame = CGRect.init(x: 0, y: 0, width:ScreenSize.SCREEN_WIDTH-10 , height: self.view_container.frame.height)
        
         self.cusView = Bundle.main.loadNibNamed("CustomerView", owner: self, options: nil)?.first as? CustomerView
         self.cusView.frame = CGRect.init(x: 0, y: 0, width:ScreenSize.SCREEN_WIDTH-10 , height: self.view_container.frame.height)
        self.cusView.btn_InternalNotes.addTarget(self, action: #selector(internalNotes), for: .touchUpInside)
        self.cusView.btn_Save.addTarget(self, action: #selector(btn_SaveCustomerUpdate), for: .touchUpInside)
        self.views.append(self.cusView)
        
        self.invView = Bundle.main.loadNibNamed("InventoryView", owner: self, options: nil)?.first as? InventoryView
        self.invView.vcObject = self.vcObject //To Present VC
        self.invView.frame = CGRect.init(x: 0, y: 0, width:self.view_container.frame.width , height: self.view_container.frame.height)
        self.invView.btn_save.addTarget(self, action: #selector(btn_SaveInventoryUpdate), for: .touchUpInside)
        self.invView.btn_InternalNotes.addTarget(self, action: #selector(internalNotes), for: .touchUpInside)
        self.invView.btn_selectVendor.addTarget(self, action: #selector(btn_Tapped_selectVendor), for: .touchUpInside)
        self.invView.btn_selectVendor.isHidden = true
        self.views.append(self.invView)
         
         for v in self.views
         {
            self.view_container.addSubview(v)
         }
        
         self.view_container.bringSubview(toFront: self.views[0])
         self.updateContainerFrame(view:self.views[0])
    }
    
    func updateContainerFrame(view:UIView)
    {
        let origin = self.view_container.frame.origin
        let size =   view.frame.size

        self.view_container.frame = CGRect.init(x: origin.x, y: origin.y, width: ScreenSize.SCREEN_WIDTH-10, height: size.height)
    }
    
    func updateView()
    {
        if let _ = self.rmaStruct
        {
            //CustomerSide
            switch self.rmaStruct.customer_side.lowercased()
            {
                case "exchange", "exchanged":
                    self.cusView.btn_Save.isHidden = false
                    self.cusView.btn_Exchanged.updateButtonState(isSelected: true)
                
                case "need to refund", "refunded":
                    self.cusView.btn_Save.isHidden = false
                    self.cusView.btn_Refend.updateButtonState(isSelected: true)
                
                case "pending":
                    self.cusView.btn_Save.isHidden = false
                    self.cusView.btn_Pending.updateButtonState(isSelected: true)
                
                default:
                break
            }
            
            //InventorySide
            self.invView.showLabels(isHidden:true)
            self.invView.height_Container.constant =  115.0
            
            switch self.rmaStruct.inventory_side.lowercased()
            {
                case "resale as a used":
                    self.invView.btn_save.isHidden = false
                    self.invView.btn_ResaleAsUsed.updateButtonState(isSelected: true)
                    break
                
                case "resale as a new":
                    self.invView.btn_save.isHidden = false
                    self.invView.btn_ResaleAsNew.updateButtonState(isSelected: true)
                    self.invView.showLabels(isHidden:true)
                    self.invView.height_Container.constant =  115.0
                    break
                
                case "defective not working":
                    self.invView.btn_save.isHidden = false
                    self.invView.btn_DefectiveNotWorking.updateButtonState(isSelected: true)
                    self.invView.showRadioButtons(isShow: false)
                    self.invView.height_Container.constant =  270.0
                    
                    if self.rmaStruct.defective_option.lowercased() == "defective unknown vendor"
                    {
                        self.invView.btn_unknownVendor.isSelected = true
                    }
                    else if self.rmaStruct.defective_option.lowercased() == "defective can not return to vendor"
                    {
                        self.invView.btn_notReturnToVendor.isSelected = true
                    }
                    else if self.rmaStruct.defective_option.lowercased() == "defective return to vendor"
                    {
                        self.invView.btn_ReturnToVendor.isSelected = true
                        if DeviceType.IS_IPAD
                        {
                           self.invView.height_Container.constant =  310.0
                            self.invView.btn_selectVendor.layoutIfNeeded()
                            self.invView.btn_selectVendor.layoutSubviews()
                            self.invView.btn_selectVendor.backgroundColor = ColorConstant.blueFillColor
                            self.invView.btn_selectVendor.updateConstraints()
                            self.invView.btn_selectVendor.setNeedsDisplay()
                          
                        }
                    }
                    
                    
                    if self.invView.btn_ReturnToVendor.isSelected == true
                    {
                        self.invView.btn_selectVendor.isHidden = false
                        
                        if self.rmaStruct.vendor.count != 0  //Vendor Selected
                        {
                            self.invView.btn_selectVendor.setTitle("   \(self.rmaStruct.vendor!)   ", for: .normal)
                            self.vendorName = self.rmaStruct.vendor!
                            
                        }
                    }
                    else
                    {
                        self.invView.btn_selectVendor.isHidden = true
                    }
                    break
                
                default:
                    break
            }
        }
    }
    
    @objc func internalNotes()
    {
        if let _ = delegate_InternalProtocol
        {
            self.delegate_InternalProtocol.didTappedInternalProtocols()
        }
    }
    
    @IBAction func segmentButtonTapped(sender:UISegmentedControl)
    {
        self.view_container.bringSubview(toFront: self.views[sender.selectedSegmentIndex])
        self.views[sender.selectedSegmentIndex].setNeedsUpdateConstraints()
        self.updateContainerFrame(view: self.views[sender.selectedSegmentIndex])
    }
    
    @objc func btn_Tapped_selectVendor()
    {
        NetworkManager.sharedManager.getVendorsList { (vendorsList) in
            
            if let _ = vendorsList
            {
                let vc = VendorSelectionVC.init(nibName: "VendorSelectionVC", bundle: nil)
                vc.vendors = vendorsList
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                vc.delegateVendor = self
                self.vcObject.present(vc, animated: true, completion: nil)
            }
        }
    }
   
    //MARK: VendorSelectionProtocol Methods
    func didSelectVendor(name:String)
    {
        DispatchQueue.main.async {
            self.vendorName = name
            self.invView.btn_selectVendor.setTitle("   \(name)   ", for: .normal)
            self.invView.btn_selectVendor.layoutIfNeeded()
        }
    }
    
    
    //MARK: Update Rma Customer-Inventory
    @objc func btn_SaveCustomerUpdate()
    {
        let loginUser = DrConstants.kAppDelegate.loginUser
        var prop:[String: String] = ["ticket_id": self.rmaStruct.id!, "emp_id": (loginUser?.id!)!]
        
        if self.cusView.btn_Exchanged.isSelected
        {
            prop["value"] = "exchange"
        }
        else if self.cusView.btn_Refend.isSelected
        {
            prop["value"] = "need to refund"
        }
        else if self.cusView.btn_Pending.isSelected
        {
            prop["value"] = "pending"
        }
        
        NetworkManager.sharedManager.updateCustomerSide(prop: prop) { (isUpdated) in
            if isUpdated!
            {
                print("\n Customer Side Update")
                self.vcObject.navigationController?.popViewController(animated: true)
            }
            else
            {
                print("\n Customer Side not Update")
            }
            
        }
    }
    
    @objc func btn_SaveInventoryUpdate()
    {
        let loginUser = DrConstants.kAppDelegate.loginUser
        var prop:[String: String] = ["ticket_id": self.rmaStruct.id!, "emp_id": (loginUser?.id!)!]
        
        if self.invView.btn_ResaleAsUsed.isSelected
        {
            prop["value"] = "Resale as a used"
        }
        else if self.invView.btn_ResaleAsNew.isSelected
        {
            prop["value"] = "Resale as a new"
        }
        else if self.invView.btn_DefectiveNotWorking.isSelected
        {
            prop["value"] = "Defective not working"
            
            //Only Incase on Defective Not Working
            if self.invView.btn_unknownVendor.isSelected
            {
                prop["defective_option"] = "Defective unknown vendor"
                prop["vendor_name"] = nil
            }
            else if self.invView.btn_notReturnToVendor.isSelected
            {
                 prop["defective_option"] = "Defective can not return to vendor"
                 prop["vendor_name"] = nil
            }
            else if self.invView.btn_ReturnToVendor.isSelected
            {
                 prop["defective_option"] = "Defective return to vendor"
                 if let _ = self.vendorName
                 {
                    prop["vendor_name"] = self.vendorName
                 }
            }
        }
        
        NetworkManager.sharedManager.updateInventorySide(prop: prop) { (isUpdated) in
            if isUpdated!
            {
                print("\n Inventory Side Update")
                self.vcObject.navigationController?.popViewController(animated: true)
            }
            else
            {
                print("\n Inventory Side not Update")
            }
        }
    }
}
