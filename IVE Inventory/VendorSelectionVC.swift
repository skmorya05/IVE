//
//  VendorSelectionVC.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 12/03/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

protocol VendorSelectionProtocol:class
{
    func didSelectVendor(name:String)
}


class VendorSelectionVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var pickerView: UIPickerView!
    var vendors:[[String:Any]]!
    var selectedStr:String!
    var delegateVendor:VendorSelectionProtocol!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let dict = self.vendors[0]
        if let name = dict["name"] as? String
        {
            self.selectedStr = name
        }
    }
    
    //MARK: Buttons Actions
    @IBAction func btn_Tapped_Cancel(sender:Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btn_Tapped_Done(sender:Any)
    {
        self.dismiss(animated: true) {
            if let _ = self.delegateVendor
            {
                if let _ = self.selectedStr
                {
                    self.delegateVendor.didSelectVendor(name: self.selectedStr!)
                }
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return vendors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if let name = vendors[row]["name"] as? String
        {
           return name
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if let name = vendors[row]["name"] as? String
        {
            self.selectedStr = name
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
