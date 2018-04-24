//
//  IVEVendor.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 23/04/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation

struct IVEVendor {
 
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var openStatus: String = "0"
    var shipStatus: String = "0"
    
    init(dict:[String: Any])
    {
        if let name = dict["name"] as? String
        {
            self.name = name
        }
        
        if let email = dict["email"] as? String
        {
            self.email = email
        }
        
        if let phone = dict["phone"] as? String
        {
            self.phone = phone
        }
        
        if let shippedsts = dict["shippedsts"] as? Int
        {
            self.shipStatus = "\(shippedsts)"
        }
        
        if let opensts = dict["opensts"] as? Int
        {
            self.openStatus = "\(opensts)"
        }
    }
}
