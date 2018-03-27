//
//  IVEEnum.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 16/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation

struct Return {
    var id: String!
    var rma: String!
    var serial: String!
    var brand: String!
    var model: String!
    var status: String!
    var name: String!

    var createdate: String!
    var reason: String!
    var closedate: String!
    var closeby: String!
    
    var sales_receipt: String!
    var email: String!
    var phone: String!
    var company_name: String!
    
    var address: String!
    var city: String!
    var state: String!
    var country: String!
    var zip: String!
    
    var secondary_phone: String!
    var date_created: String!
    var close_date: String!
    var by: String!
    var return_type: String!
    var shipping_method: String!
    var purchase_date: String!
    var orders: String!
    var rma_type: String!
    var defective_explain: String!
    var defective_option: String!
    var vendor: String!

    
    //Status
    var item_receive: String!
    var customer_side: String!
    var inventory_side: String!
    
    init(dict:[String:Any])
    {
        if let id = dict["id"] as? String
        {
            self.id = id
        }
        else
        {
            self.id = ""
        }
        
        if let rma = dict["rma"] as? String
        {
            self.rma = rma
        }
        else
        {
            self.rma = ""
        }
        
        if let serial = dict["serial"] as? String
        {
            self.serial = serial
        }
        else
        {
            self.serial = ""
        }
        
        if let brand = dict["brand"] as? String
        {
            self.brand = brand
        }
        else
        {
            self.brand = ""
        }
        
        if let model = dict["model"] as? String
        {
            self.model = model
        }
        else
        {
            self.model = ""
        }
        
        if let status = dict["status"] as? String
        {
            self.status = status
        }
        else
        {
            self.status = ""
        }
        
        if let name = dict["user_name"] as? String
        {
            self.name = name
        }
        else
        {
            self.name = ""
        }
        
        if var createdate = dict["date_created"] as? String
        {
            createdate = createdate.replacingOccurrences(of: "00:00:00", with: "")
            self.createdate = createdate
        }
        else
        {
            self.createdate = ""
        }
        
        if let reason = dict["reason_return"] as? String
        {
            self.reason = reason
        }
        else
        {
            self.reason = ""
        }
        
        if var closedate = dict["close_date"] as? String
        {
            closedate = closedate.replacingOccurrences(of: "00:00:00", with: "")
            self.closedate = closedate
        }
        else
        {
            self.closedate = ""
        }
        
        if let closeby = dict["by"] as? String
        {
            self.closeby = closeby
        }
        else
        {
            self.closeby = ""
        }
        
        if let address = dict["address"] as? String
        {
            self.address = address
        }
        else
        {
            self.address = ""
        }
        
        if let city = dict["city"] as? String
        {
            self.city = city
        }
        else
        {
            self.city = ""
        }
        
        if let state = dict["state"] as? String
        {
            self.state = state
        }
        else
        {
            self.state = ""
        }
        
        if let country = dict["country"] as? String
        {
            self.country = country
        }
        else
        {
            self.country = ""
        }
        
        if let zip = dict["zip"] as? String
        {
            self.zip = zip
        }
        else
        {
            self.zip = ""
        }
        
        self.address = "\(self.address!) \(self.city!) \(self.state!) \(self.country!) \(self.zip!)"
        
        if let secondary_phone = dict["secondary_phone"] as? String
        {
            self.secondary_phone = secondary_phone
        }
        else
        {
            self.secondary_phone = ""
        }
        
        if let date_created = dict["date_created"] as? String
        {
            self.date_created = date_created
        }
        else
        {
            self.date_created = ""
        }
        
        if let close_date = dict["close_date"] as? String
        {
            self.close_date = close_date
        }
        else
        {
            self.close_date = ""
        }
        
        if let by = dict["by"] as? String
        {
            self.by = by
        }
        else
        {
            self.by = ""
        }
        
        if let return_type = dict["return_type"] as? String
        {
            self.return_type = return_type
        }
        else
        {
            self.return_type = ""
        }
        
        if let shipping_method = dict["shipping_method"] as? String
        {
            self.shipping_method = shipping_method
        }
        else
        {
            self.shipping_method = ""
        }
        
        if let purchase_date = dict["purchase_date"] as? String
        {
            self.purchase_date = purchase_date
        }
        else
        {
            self.purchase_date = ""
        }
        
        if let orders = dict["orders"] as? String
        {
            self.orders = orders
        }
        else
        {
            self.orders = ""
        }
        
        if let rma_type = dict["rma_type"] as? String
        {
            self.rma_type = rma_type
        }
        else
        {
            self.rma_type = ""
        }
        
        if let defective_explain = dict["defective_explain"] as? String
        {
            self.defective_explain = defective_explain
        }
        else
        {
            self.defective_explain = ""
        }
        
        
        //#Rma-Status
        if let receive = dict["item_receive"] as? String
        {
            self.item_receive = receive
        }
        else
        {
            self.item_receive = "No"
        }
        
        if let customer_side = dict["customer_side"] as? String
        {
            self.customer_side = customer_side
        }
        else
        {
            self.customer_side = "No"
        }
        
        if let inventory_side = dict["inventory_side"] as? String
        {
            self.inventory_side = inventory_side
        }
        else
        {
            self.inventory_side = "No"
        }
        
        if let defective_option = dict["defective_option"] as? String
        {
            self.defective_option = defective_option
        }
        else
        {
            self.defective_option = ""
        }
        
        if let vendor = dict["vendor"] as? String
        {
            self.vendor = vendor
        }
        else
        {
            self.vendor = ""
        }
        
    }
}



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
    var access: [String]!
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
        
        if let access = dict["access"] as? [String]
        {
            self.access = access
        }
        else
        {
            self.access = []
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
        
        if let image = dict["photo"] as? String
        {
            self.photo = image
        }
        else
        {
            self.photo = ""
        }
    }
}

