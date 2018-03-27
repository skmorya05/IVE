//
//  Delegate_InventoryReceipt.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 08/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation
import UIKit

class Delegate_InventoryReceipt: NSObject
{
    var receipts:[IVEReceipt]!
    var menuBtnDelegate:MenuSelectionProtocol!
}

extension Delegate_InventoryReceipt: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if let _ = self.menuBtnDelegate
        {
            self.menuBtnDelegate.didSelectMenuButton(indexPath: indexPath)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if let _ = self.menuBtnDelegate
        {
          self.menuBtnDelegate.didScrollTableView()
        }
    }
}
