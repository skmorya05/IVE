//
//  IVE_UserManager.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 14/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation

struct IVE_User {
    var name: String!
    var email: String!
    var mobile: String!
    var address: String!
    var created_date: String!
    var initial: String!
    var gender: String!
    var role: String!
    var id: String!
    var access: String!
    var photo: String!
    var is_deleted: String!
    var pin: String!
    
    init(dict:[String:Any])
    {
        if let name = dict["name"] as? String
        {
            self.name = name
        }
        else
        {
            self.name = ""
        }
            
        if let email = dict["email"] as? String
        {
            self.email = email
        }
        else
        {
            self.email = ""
        }
        
        if let mobile = dict["mobile"] as? String
        {
            self.mobile = mobile
        }
        else
        {
            self.mobile = ""
        }
        
        if let address = dict["address"] as? String
        {
            self.address = address
        }
        else
        {
            self.address = ""
        }
        
        if let created_date = dict["created_date"] as? String
        {
            self.created_date = created_date
        }
        else
        {
            self.created_date = ""
        }
        
        if let initial = dict["initial"] as? String
        {
            self.initial = initial
        }
        else
        {
            self.initial = ""
        }
        
        if let gender = dict["gender"] as? String
        {
            self.gender = gender
        }
        else
        {
            self.gender = ""
        }
        
        if let role = dict["role"] as? String
        {
            self.role = role
        }
        else
        {
            self.role = ""
        }
        
        if let id = dict["id"] as? String
        {
            self.id = id
        }
        else
        {
            self.id = ""
        }
        
        if let access = dict["access"] as? String
        {
            self.access = access
        }
        else
        {
            self.access = ""
        }
        
        if let photo = dict["photo"] as? String
        {
            self.photo = photo
        }
        else
        {
            self.photo = ""
        }
        
        if let is_deleted = dict["is_deleted"] as? String
        {
            self.is_deleted = is_deleted
        }
        else
        {
            self.is_deleted = ""
        }
        
        if let pin = dict["pin"] as? String
        {
            self.pin = pin
        }
        else
        {
            self.pin = ""
        }
    }
}
