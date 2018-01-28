//
//  NetworkManager.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 02/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
// Avaneesh Singh

import Foundation
import Alamofire

typealias serviceCompletion = (_ : Any?, _ : String?) -> Void

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
                
                guard let value = response.result.value as? [String: Any], let loginDict = value[IVE_KeyConstant.kData] as? [String: Any] else
                {
                    print("Value is not in specified format")
                    return
                }
                
                
                let userStruct = IVE_User.init(dict: loginDict)
                
                completion(userStruct)
        }
        
    }
    
    func registerUser(properties:[String: String]?, completion:@escaping (_ dict:IVE_User?)->Void)
    {
        if let prop = properties
        {
            print("\n prop = \(prop)")
            
            Alamofire.request(
                URL(string: "\(IVE_URLConstant.kRegisterUser)")!,
                method: .post,
                parameters: prop)
                .validate()
                .responseJSON { (response) -> Void in
                    
                    print("response.result.value = \(response.result.value)")
                    
                    guard response.result.isSuccess else
                    {
                        print("Error: \(String(describing: response.result.error))")
                        return
                    }
                    
                    guard let value = response.result.value as? [String: Any] ,
                    let dict = value[IVE_KeyConstant.kData] as? [String: Any] else
                    {
                        return
                    }
                    
                    let userStruct = IVE_User.init(dict: dict)
                    completion(userStruct)
            }
            
            
            
            
            
            
            
            
            
           /* let headers: HTTPHeaders = [
                "Content-Type":"multipart/form-data",
                "Accept": "application/json"
            ]
            
            Alamofire.request(URL(string: IVE_URLConstant.kRegisterUser)!, method: .post, parameters:prop , encoding: JSONEncoding(), headers: headers).responseJSON{ (response) -> Void in
                    
                    print("result = \(response.result)")
                    
                    guard response.result.isSuccess else
                    {
                        print("Error: \(String(describing: response.result.error))")
                        return
                    }
                    
                    guard let value = response.result.value as? [String: Any],
                    let dict = value[IVE_KeyConstant.kData] as? [String: Any] else
                    {
                        print("Malformed data received from fetchAllRooms service")
                        return
                    }
                    
                    let user = IVE_User.init(dict: dict)
                    completion(user)
            }
 
             */

            
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
    
    func getUsersList(completion:@escaping (_ users:[IVE_User]?) -> Void)
    {
        Alamofire.request(
            URL(string: IVE_URLConstant.kUsersList)!,
            method: .get,
            parameters: nil)
            .validate()
            .responseJSON { (response) -> Void in
                
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                guard let value = response.result.value as? [String: Any], let usersList = value[IVE_KeyConstant.kData] as? [[String: Any]] else
                {
                    print("Value is not in specified format")
                    return
                }
                
                let users = usersList.flatMap({ (dict) -> IVE_User? in
                    return IVE_User.init(dict: dict)
                })
                
                completion(users)
                
        }
    }
    
    func updateUserDict(user:IVE_User, status:Bool, completion:@escaping (_ result: Bool)->Void)
    {
        let isDeleted = status ? "0" : "1"
        let prop = [IVE_KeyConstant.kIs_deleted: isDeleted]
        Alamofire.request(
            URL(string: "\(IVE_URLConstant.kUsersUpdate)\(user.id!)")!,
            method: .post,
            parameters: prop)
            .validate()
            .responseJSON { (response) -> Void in
                
                //print("response.result.value = \(response.result.value)")
                
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                guard let dict = response.result.value as? [String: Any] else
                {
                    return
                }
                
                completion(true)
        }
    }
    
    func updateUserAccessDict(user:IVE_User, access:[String], completion:@escaping (_ success:Bool)-> Void)
    {
        var prop = [String: [String]]()
        prop[IVE_KeyConstant.kAccess] = access
        
        Alamofire.request(
            URL(string: "\(IVE_URLConstant.kUsersUpdate)\(user.id!)")!,
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
                    return
                }
                
                if let status = dict[IVE_KeyConstant.kStatus] as? String, status == IVE_KeyConstant.kSuccess
                {
                    completion(true)
                }
                else
                {
                    completion(false)
                }
          }
    }
    
   /* func updateUser(imageData:Data, userid:String)
    {
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("photo.jpg")
        let url = URL.init(string: paths as String)
        
        if fileManager.fileExists(atPath: paths)
        {
            try! fileManager.removeItem(atPath: paths)
        }
        else
        {
            print("Something wronge.")
        }
        
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
        
        // Use Alamofire to upload the image
        Alamofire.upload( multipartFormData: { (multipartFormData:MultipartFormData) in
                // On the PHP side you can retrive the image using $_FILES["image"]["tmp_name"]
                    multipartFormData.append(imageData, withName: "photo")
                },
                to: URL(string: "\(IVE_URLConstant.kPhotoUpdate)\(userid)")!,
                encodingCompletion: { encodingResult in
                         switch encodingResult {
                         case .success(let upload, _, _):
                             upload.responseJSON { response in
                                 if let jsonResponse = response.result.value as? [String: Any]
                                 {
                                     print(jsonResponse)
                                 }
                             }
                         case .failure(let encodingError):
                             print(encodingError)
                         }
                 }
          )
    }*/
 
    
    func uploadImage(_ imageData:Data, _ userid:String , _ parameters: [String: Any]?,  withCompletion getResponse: @escaping serviceCompletion)
    {        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(imageData, withName: "file", fileName: "file.png", mimeType: "image/png")
            
            if let allParams = parameters as? [String:String] {
                for (key, value) in allParams {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
            }}, to: URL(string: "\(IVE_URLConstant.kPhotoUpdate)\(userid)")!, method: .post, headers: nil,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _,_):
                        upload.response { [weak self] response in
                            guard self != nil else {
                                getResponse("Something went wrong",nil)
                                return
                            }
                            debugPrint(response)
                            getResponse(response,nil)
                        }
                    case .failure(let encodingError):
                        print("error:\(encodingError)")
                        getResponse(nil, encodingError.localizedDescription)
                    }
        })
    }
 
}
