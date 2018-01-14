//
//  ReturnDataSource.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 24/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit

enum SCREEN_MODE
{
    case PRINT
    case NONE
}

class ReturnDataSource: NSObject {

    var tableView:UITableView!
    var returnList = [Return]()
    var printList = [Return]()
    var screenMode = SCREEN_MODE.NONE
    var radioButtonDelegate:RadioButtonProtocol!
    
}

extension ReturnDataSource: UITableViewDataSource, RadioButtonProtocol
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return returnList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnCell", for: indexPath) as! ReturnCell
        cell.contentView.backgroundColor = ColorConstant.blueFillColor
        let returnItem = self.returnList[indexPath.row]
        //print("returnItem = \(returnItem)")
        
        cell.dataStruct = returnItem
        cell.lbl_rma.text = returnItem.rma
        cell.lbl_serial.text = returnItem.serial
        cell.lbl_brand.text = returnItem.brand
        cell.lbl_model.text = returnItem.model
        cell.lbl_name.text = returnItem.name
        cell.lbl_createdate.text = returnItem.createdate
        cell.lbl_reason.text = returnItem.reason
        cell.lbl_closedate.text = returnItem.closedate
        cell.lbl_closeby.text = returnItem.closeby
        
        cell.btn_Radio.isHidden = true
        if self.screenMode == .PRINT
        {
            cell.btn_Radio.isHidden = false
        }

        cell.radioButtonDelegate = self
        
        
        let isContains = self.printList.contains { (obj:Return) -> Bool in
            
            if (obj.rma == cell.dataStruct.rma)
            {
                return true
            }
            
            
            
            return false
        }
        
        if isContains == true
        {
            cell.btn_Radio.isSelected = true
        }
        else
        {
           cell.btn_Radio.isSelected = false
        }
        
        print("\n returnItem.status = \(returnItem.status)")
        
        if returnItem.status == "open"
        {
            cell.imgView_Status.isHidden = true
        }
        else
        {
            cell.imgView_Status.isHidden = false
        }
        
        
        return cell
    }
    
    func didSelectRadioButton(cell:ReturnCell)
    {
        if let _ = self.radioButtonDelegate
        {
            self.radioButtonDelegate.didSelectRadioButton(cell: cell)
        }
    }
    
    func didSelectRadioHaveStructure(returnStruct: Return)
    {
       //No Need
    }
    
}
