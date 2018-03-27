//
//  Delegate_DetailsVC.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 03/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation

class Delegate_DetailsVC: NSObject
{
    
}

extension Delegate_DetailsVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0
        {
            return UITableViewAutomaticDimension
        }
        else
        {
            if DrConstants.kDevice == .phone
            {
                return 450
            }
            
            return 550
        }
    }
}
