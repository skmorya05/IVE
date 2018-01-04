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
        do {
            if let file = Bundle.main.url(forResource: "return", withExtension: "json")
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
                
               /* let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any]
                {
                    print(object)
                }
                else if let array = json as? [[String: Any]]
                {
                    var list = [Return]()
                    for object in array
                    {
                        let returnStruct = Return.init(dict: object )
                        list.append(returnStruct)
                    }
                    
                    completion(list)
                }
                else
                {
                    completion(nil)
                    print("JSON is invalid")
                } */
            }
            else
            {
                completion(nil)
                print("no file")
            }
        }
        catch
        {
            completion(nil)
            print(error.localizedDescription)
        }
    }
    
}



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
    
    init(dict:[String:Any])
    {
        if let id = dict["id"] as? String
        {
            self.id = id
        }
        if let rma = dict["rma"] as? String
        {
            self.rma = rma
        }
        if let serial = dict["serial"] as? String
        {
            self.serial = serial
        }
        if let brand = dict["brand"] as? String
        {
            self.brand = brand
        }
        if let model = dict["model"] as? String
        {
            self.model = model
        }
        if let status = dict["status"] as? String
        {
            self.status = status
        }
        if let name = dict["user_name"] as? String
        {
            self.name = name
        }
        if var createdate = dict["date_created"] as? String
        {
            createdate = createdate.replacingOccurrences(of: "00:00:00", with: "")
            self.createdate = createdate
        }
        if let reason = dict["reason_return"] as? String
        {
            self.reason = reason
        }
        if var closedate = dict["close_date"] as? String
        {
            closedate = closedate.replacingOccurrences(of: "00:00:00", with: "")
            self.closedate = closedate
        }
        if let closeby = dict["by"] as? String
        {
            self.closeby = closeby
        }
        
    }
}
