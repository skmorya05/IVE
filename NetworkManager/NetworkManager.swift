//
//  NetworkManager.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 02/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
// Avaneesh Singh

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
                        print("Error: \(String(describing: response.result.error))")
                        return
                    }
                    
                    guard (response.result.value as? [String: Any]) != nil else
                    {
                        print("Malformed data received from fetchAllRooms service")
                        return
                    }
                    
                    completion(true)
            }
        }
    }
    
    func getRmaDetails(rma:String, completion:@escaping (_ return:Return?)->Void) {
        
        let property:[String: String] = ["id":rma]
        Alamofire.request(
            URL(string: IVE_URLConstant.kRmaDetail)!,
            method: .get,
            parameters: property)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else
                {
                    //print("Error: \(response.result.error)")
                    return
                }
                
                guard let rmaDict = response.result.value as? [String: Any] else
                {
                    print("Malformed data received from fetchAllRooms service")
                    return
                }
                
                let room = Return.init(dict: rmaDict)

                completion(room)
        }
        
    }
    
    func getLoginDetails(dict:[String: String], completion:@escaping (_ user:IVE_User?)->Void) {
        
        guard let _ = dict[IVE_KeyConstant.kName] else
        {
            return
        }
        
        guard let _ = dict[IVE_KeyConstant.kPassword] else
        {
            return
        }
        
        Alamofire.request(
            URL(string: IVE_URLConstant.kLogin)!,
            method: .get,
            parameters: dict)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                guard let loginDict = response.result.value as? [String: Any] else
                {
                    print("Value is not in specified format")
                    return
                }
                
                let userStruct = IVE_User.init(dict: loginDict)
                
                completion(userStruct)
        }
        
    }
    
    func registerUser(properties:[String: Any]?, completion:@escaping (_ dict:[String: Any]?)->Void)
    {
        if let prop = properties
        {
            Alamofire.request(
                URL(string: IVE_URLConstant.kRegisterUser)!,
                method: .post,
                parameters: prop)
                .validate()
                .responseJSON { (response) -> Void in
                    guard response.result.isSuccess else
                    {
                        print("Error: \(String(describing: response.result.error))")
                        return
                    }
                    
                    guard let dict = response.result.value as? [String: Any] else
                    {
                        print("Malformed data received from fetchAllRooms service")
                        return
                    }
                    
                    completion(dict)
            }
            

            
           /*Alamofire.upload(multipartFormData: { multipartFormData in
                // import image to request
                
                multipartFormData.append(imagedata, withName: "photo")
                
                for (key, value) in parameters
                {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to: IVE_URLConstant.kRegisterUser, encodingCompletion: {
                switch encodingResult
                {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            
                        }
                    case .failure(let error):
                        print(error)
                }
            })*/
        }
    }
    
}
