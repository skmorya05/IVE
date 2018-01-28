//
//  UserDetailViewController.swift
//  IVE Inventory
//
//  Created by Vivan Raghuvanshi on 05/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    //MARK: -------------OUTLETS/VARIABLES----------------
    @IBOutlet weak var switch_adminAccess:UISwitch!
    @IBOutlet weak var switch_Return:UISwitch!
    @IBOutlet weak var switch_RmaDetail:UISwitch!
    @IBOutlet weak var switch_RmaPrint:UISwitch!
    @IBOutlet weak var switch_Vendors:UISwitch!
    
    @IBOutlet weak var label_adminAccess:UILabel!
    @IBOutlet weak var label_Return:UILabel!
    @IBOutlet weak var label_RmaDetail:UILabel!
    @IBOutlet weak var label_RmaPrint:UILabel!
    @IBOutlet weak var label_Vendors:UILabel!
    
    @IBOutlet weak var rmaDetailContainerView:UIView!
    @IBOutlet weak var rmaDetailView:UIView!
    @IBOutlet weak var rmaPrintView:UIView!
    @IBOutlet weak var btn_dropDown:UIButton!

    
    var ive_user: IVE_User!
    
    //MARK: -------------VIEW LIFE CYCLE----------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.edgesForExtendedLayout = []
        
        label_adminAccess.font = UIFont.init(name: IVEFontConstant.SFUI_TEXT_REGULAR, size: 16*DrConstants.kSCALE_FACTOR)

        print("ive_user = \(ive_user)")
        
        updateAccessButtons()
    }
    
    

    
    //MARK: -------------PRIVATE METHODS----------------
    func configureNavigationBar()
    {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem.itemWith(colorfulImage:#imageLiteral(resourceName: "backbutton_icon"), target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.title = ive_user.name ?? "User"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
    }
    
    //MARK:- NavigationBar Button Action
    @objc func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateAccessButtons()
    {
        if let accessArr = ive_user.access
        {
            print("accessArr = \(accessArr)")
            
            if accessArr.contains(IVEAccess.kAdmin_Access)
            {
                self.switch_adminAccess.isOn = true
            }
            else
            {
                self.switch_adminAccess.isOn = false
            }
            
            if accessArr.contains(IVEAccess.kReturn)
            {
                self.switch_Return.isOn = true
            }
            else
            {
                self.switch_Return.isOn = false
            }
            
            
            if accessArr.contains(IVEAccess.kRma_Detail)
            {
                self.switch_RmaDetail.isOn = true
            }
            else
            {
                self.switch_RmaDetail.isOn = false
            }
            
            
            if accessArr.contains(IVEAccess.kRma_Print)
            {
                self.switch_RmaPrint.isOn = true
            }
            else
            {
                self.switch_RmaPrint.isOn = false
            }
            
            
            if accessArr.contains(IVEAccess.kVendors)
            {
                self.switch_Vendors.isOn = true
            }
            else
            {
                self.switch_Vendors.isOn = false
            }
            
        }
    }
    
    @IBAction func dropDownButtonTapped(sender:UIButton)
    {
        if self.btn_dropDown.isSelected
        {
            self.btn_dropDown.isSelected = false
        }
        else
        {
            self.btn_dropDown.isSelected = true
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.btn_dropDown.isSelected
            {
                self.rmaDetailContainerView.isHidden = false
                for view in self.rmaDetailContainerView.subviews
                {
                    view.isHidden = false
                }
            }
            else
            {
                self.rmaDetailContainerView.isHidden = true
                for view in self.rmaDetailContainerView.subviews
                {
                    view.isHidden = true
                }
            }
        })
    
    }
    
    
    @IBAction func btnChange_AdminAccess()
    {
        switch_Return.isOn = switch_adminAccess.isOn
        switch_RmaDetail.isOn = switch_adminAccess.isOn
        switch_RmaPrint.isOn = switch_adminAccess.isOn
        switch_Vendors.isOn = switch_adminAccess.isOn
    }
    
    @IBAction func btnChange_Return()
    {
        switch_RmaDetail.isOn = switch_Return.isOn
        switch_RmaPrint.isOn = switch_Return.isOn
    }
    
    @IBAction func btnChange_RmaDetail()
    {
        if (switch_RmaDetail.isOn || switch_RmaPrint.isOn)
        {
            switch_Return.isOn = true
        }
    }
    
    @IBAction func btnChange_RmaPrint()
    {
        if (switch_RmaDetail.isOn || switch_RmaPrint.isOn)
        {
            switch_Return.isOn = true
        }
    }
    
    @IBAction func btnChange_Vendors()
    {
        //No Action Needed
    }
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(true)
        
        let accessArray = getAccessArray()
        print("accessArray = \(accessArray)")
        NetworkManager.sharedManager.updateUserAccessDict(user: self.ive_user, access:accessArray) { (result:Bool) in
            print("updated = \(result) ")
        }
    }
    
    func getAccessArray() -> [String]
    {
        var accessArr = [String]()
        
        if switch_adminAccess.isOn
        {
            accessArr.append(IVEAccess.kAdmin_Access)
        }
        if switch_Return.isOn
        {
            accessArr.append(IVEAccess.kReturn)
        }
        if switch_RmaDetail.isOn
        {
            accessArr.append(IVEAccess.kRma_Detail)
        }
        if switch_RmaPrint.isOn
        {
            accessArr.append(IVEAccess.kRma_Print)
        }
        if switch_Vendors.isOn
        {
            accessArr.append(IVEAccess.kVendors)
        }
        
        return accessArr
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
