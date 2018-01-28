//
//  ReturnViewManager.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 24/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit
import Foundation

class ReturnViewManager {
    
    public func getReturnList(completion:@escaping (_ returnArray:[Return]?)-> Void)
    {
        NetworkManager.sharedManager.getRmaListFromServer(properties: nil, completion: { (result:Bool, list:[Return]?) in
            
            if let _ = list
            {
                completion(list)
            }
            else
            {
                completion(nil)
            }
        })
    }
    
}

