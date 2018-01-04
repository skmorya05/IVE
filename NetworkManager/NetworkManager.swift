//
//  NetworkManager.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 02/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager: NSObject
{
    static let sharedManager = NetworkManager()
    
    func getRmaListFromServer(properties:[String: Any]?, completion:@escaping (_ isFound:Bool, _ returnList:[Return]?)->Void)
    {
        Alamofire.request(
            URL(string: IVE_URLConstant.kRmaList)!,
            method: .get,
            parameters: nil)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else
                {
                    //print("Error: \(response.result.error)")
                    return 
                }
                
                guard let value = response.result.value as? [String: Any],
                    let rows = value["data"] as? [[String: Any]] else
                {
                        print("Malformed data received from fetchAllRooms service")
                        return
                }
                
                let rooms = rows.flatMap({ (rmaDict) -> Return? in
                    return Return.init(dict: rmaDict)
                })
                
                completion(true, rooms)
        }
    }
    
    func updateRma(properties:[String: Any]?, completion:@escaping (_ isUpdate:Bool)->Void)
    {
        if let prop = properties
        {
            guard let id = prop["id"] as? String else
            {
                return
            }
            
            Alamofire.request(
                URL(string: IVE_URLConstant.kRmaUpdate+id)!,
                method: .post,
                parameters: prop)
                .validate()
                .responseJSON { (response) -> Void in
                    guard response.result.isSuccess else
                    {
                        print("Error: \(response.result.error)")
                        return
                    }
                    
                    guard let value = response.result.value as? [String: Any] else
                    {
                        print("Malformed data received from fetchAllRooms service")
                        return
                    }
                    
                    completion(true)
            }
        }
    }
}
