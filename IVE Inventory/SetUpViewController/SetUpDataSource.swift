//
//  SetUpDataSource.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 14/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation



class SetUpDataSource: NSObject {
    
    var usersList: [IVE_User]!
    var viewControllerObj: SetUpViewController!
}

extension SetUpDataSource: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SetUpCell", for: indexPath) as! SetUpCell
        cell.delegate = viewControllerObj
        
        let userStruct = self.usersList[indexPath.row]
        cell.ive_user = userStruct

        cell.lbl_userName.text = userStruct.name
        cell.lbl_userName?.font = UIFont.systemFont(ofSize: 20 * DrConstants.kSCALE_FACTOR)
        cell.lbl_userName?.textColor = #colorLiteral(red: 0.01176470588, green: 0.03921568627, blue: 0.3568627451, alpha: 1)
        cell.selectionStyle = .none
        
        cell.switch_role.tintColor = #colorLiteral(red: 0.01176470588, green: 0.03921568627, blue: 0.3568627451, alpha: 1)
        cell.switch_role.onTintColor = #colorLiteral(red: 0.01176470588, green: 0.03921568627, blue: 0.3568627451, alpha: 1)
        cell.switch_role.thumbTintColor = #colorLiteral(red: 0.7072623372, green: 0.7366045117, blue: 0.7719837427, alpha: 1)
        
        if userStruct.is_deleted == "0"
        {
            cell.switch_role.setOn(true, animated: false)
        }
        else
        {
            cell.switch_role.setOn(false, animated: false)
        }
        
        return cell
    }
    
   
}
