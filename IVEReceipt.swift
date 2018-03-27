//
//  IVEReceipt.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 17/03/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation

struct IVEReceipt
{
    var id: String!
    var receipt_no: String!
    var name: String!
    var description: String!
    var date_created: String!
    var price_ok: String!
    var received_qb: String!
    var invoice_paid: String!
    var images: [[String:Any]]!

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
        
        if let receipt_no = dict["receipt_no"] as? String
        {
            self.receipt_no = receipt_no
        }
        else
        {
            self.receipt_no = ""
        }
        
        if let name = dict["name"] as? String
        {
            self.name = name
        }
        else
        {
            self.name = ""
        }
        
        if let description = dict["description"] as? String
        {
            self.description = description
        }
        else
        {
            self.description = ""
        }
        
        if let date_created = dict["date_created"] as? String
        {
            self.date_created = date_created
        }
        else
        {
            self.date_created = ""
        }
        
        if let price_ok = dict["price_ok"] as? String
        {
            self.price_ok = price_ok
        }
        else
        {
            self.price_ok = ""
        }
        
        if let received_qb = dict["received_qb"] as? String
        {
            self.received_qb = received_qb
        }
        else
        {
            self.received_qb = ""
        }
        
        if let invoice_paid = dict["invoice_paid"] as? String
        {
            self.invoice_paid = invoice_paid
        }
        else
        {
            self.invoice_paid = ""
        }
        
        if let images = dict["images"] as? [[String:String]]
        {
            self.images = images
        }
        else
        {
            self.images = []
        }
    }
}
