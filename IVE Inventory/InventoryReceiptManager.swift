//
//  InventoryReceiptManager.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 17/03/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation

class InventoryReceiptManager {
    
    public func getReceiptList(completion:@escaping (_ receiptList:[IVEReceipt]?)->Void)
    {
        NetworkManager.sharedManager.getInventoryReceiptListFromServer { (receipts) in
            if let _ = receipts
            {
                completion(receipts)
            }
        }
    }
    
}
