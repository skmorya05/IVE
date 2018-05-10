//
//  NetworkManager.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 02/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
// Avaneesh Singh

import Foundation
import Alamofire

typealias serviceCompletion = (_ isSuccess:Bool) -> Void

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
                        return
                }
                
                print("Rows = \(rows)")
                
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
                    
                    //print("response.result.value = \(response.result.value)")
                    
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
 
    
    func uploadImage(_ image:UIImage, _ userid:String , _ parameters: [String: Any]?,  withCompletion completion:@escaping (_ isSuccess: Bool)-> Void)
    {        
       
        Alamofire.request(
            URL(string: "\(IVE_URLConstant.kPhotoUpdate)\(userid)")!,
            method: .post,
            parameters: ["photo":image.base64(format: .JPEG(0.7))!])
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                guard let value = response.result.value as? [String: Any], let status = value["status"] as? String else
                {
                    print("value = \(String(describing: response.result.value))")
                    return
                }
                
                if status == "success"
                {
                    completion(true)
                }
                else
                {
                    completion(false)
                }
        }
        
        
        
        
      /*  Alamofire.upload(multipartFormData: { multipartFormData in
            
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
        }) */
    }
    
    func getVendorsList(completion:@escaping (_ vendors:[[String:Any]]?) -> Void)
    {
        Alamofire.request(
            URL(string: IVE_URLConstant.kVendorsList)!,
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
                
                print("\n usersList = \(usersList)")
                completion(usersList)
                
        }
    }
    
    func getRmaStatusList(vendorid: String ,completion:@escaping (_ rmaStatusList:[[String:Any]]?) -> Void)
    {
        Alamofire.request(
            URL(string: IVE_URLConstant.kVendorsRmaList)!,
            method: .get,
            parameters: ["vendor_id": vendorid])
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
                
                completion(usersList)
        }
    }
    
    func updateRmaStatus(prop:[String:String], completion:@escaping (_ isUpdate:Bool?) -> Void)
    {
        Alamofire.request(
            URL(string: "\(IVE_URLConstant.kVendorsRmaUpdate)")!,
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
                
                if let _ = dict["status"]
                {
                    completion(true)
                }
                else
                {
                    completion(false)
                }
                
            }
    }
    
    
    func getRmaLogsList( rmaId:String , completion:@escaping (_ rmaLogs:[[String:Any]]?) -> Void)
    {
        Alamofire.request(
            URL(string: IVE_URLConstant.kInternalNotes)!,
            method: .get,
            parameters: [IVE_KeyConstant.kId: rmaId])
            .validate()
            .responseJSON { (response) -> Void in
                
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                guard let value = response.result.value as? [String: Any], let rmaLogs = value[IVE_KeyConstant.kData] as? [[String: Any]] else
                {
                    print("Value is not in specified format")
                    return
                }
                
                completion(rmaLogs)
        }
    }
    
    func updateCustomerSide(prop:[String:String], completion:@escaping (_ isUpdate:Bool?) -> Void)
    {
        Alamofire.request(
            URL(string: "\(IVE_URLConstant.kCustomerSideUpdate)")!,
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
                
                if let _ = dict["status"]
                {
                    completion(true)
                }
                else
                {
                    completion(false)
                }
        }
    }
    
    func updateInventorySide(prop:[String:String], completion:@escaping (_ isUpdate:Bool?) -> Void)
    {
        Alamofire.request(
            URL(string: "\(IVE_URLConstant.kInventorySideUpdate)")!,
            method: .post,
            parameters: prop)
            .validate()
            .responseJSON { (response) -> Void in
                
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                 ///print("response.result.value: \(String(describing: response.result.value))")
                
                guard let dict = response.result.value as? [String: Any] else
                {
                    return
                }
                
                if let _ = dict["status"]
                {
                    completion(true)
                }
                else
                {
                    completion(false)
                }
        }
    }
    
    func getInventoryReceiptListFromServer(completion:@escaping (_ receiptList:[IVEReceipt]?)->Void)
    {
        Alamofire.request(
            URL(string: IVE_URLConstant.kInventoryReceipt)!,
            method: .get,
            parameters: nil)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                if let value = response.result.value as? [String: Any],
                    let status = value["status"] as? String
                {
                    if status == "success"
                    {
                        let dataArr = value["data"] as? [[String: Any]]
                        let receiptArr = dataArr?.flatMap({ (dict) -> IVEReceipt? in
                            return IVEReceipt.init(dict: dict)
                        })
                        
                        completion(receiptArr)
                    }
                }
                else
                {
                    completion(nil)
                }
         }
    }
    
    func getUpdateInventoryReceipts(mode:IR_Type, selectionStatus:String, inventory_id: String, completion:@escaping (_ status:Bool?)-> Void)
    {
        var urlString = ""
        
        if mode == .PRICE
        {
            urlString = "\(IVE_URLConstant.kPrice_ok)"
        }
        else if mode == .RECEIVED
        {
            urlString = "\(IVE_URLConstant.kReceived_qb)"
        }
        else if mode == .INVOICE
        {
            urlString = "\(IVE_URLConstant.kInvoice_paid)"
        }
        
        let prop = ["inventory_id": inventory_id, "emp_id": DrConstants.kAppDelegate.loginUser.id!, "value":selectionStatus]
        
        Alamofire.request(
            URL(string: urlString)!,
            method: .post,
            parameters: prop)
            .validate()
            .responseJSON { (response) -> Void in
                
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                print("response.result.value = \(response.result.value)")
                
                guard let dict = response.result.value as? [String: Any] else
                {
                    return
                }
                
                if let _ = dict["status"]
                {
                    completion(true)
                }
                else
                {
                    completion(false)
                }
        }
    }
    
    func getInventoryLogsList( invId:String , completion:@escaping (_ invLogs:[[String:String]]?) -> Void)
    {
        Alamofire.request(
            URL(string: "\(IVE_URLConstant.kInventory_Logs)")!,
            method: .get,
            parameters: [IVE_KeyConstant.kId: invId])
            .validate()
            .responseJSON { (response) -> Void in
                
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                

                guard let value = response.result.value as? [String: Any], let invLogs = value[IVE_KeyConstant.kData] as? [[String: String]] else
                {
                    print("Value is not in specified format")
                    return
                }
                
                print("\n invLogs = \(invLogs)")
                completion(invLogs)
                
        }
    }
    
    //MARK: Inventory Receipts upload
    func uploadInventoryReceipts(images:[UIImage], irNameStr:String, completion:@escaping ()-> Void)
    {
        var imageStrArr = [String]()
        for image in images
        {
            if let base64String = image.base64(format: .JPEG(0.7))
            {
                imageStrArr.append(base64String)
            }
        }
        
        Alamofire.request(
            URL(string: "\(IVE_URLConstant.kInventory_Submit)")!,
            method: .post,
            parameters: ["name":irNameStr, "images":imageStrArr])
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                guard let value = response.result.value as? [String: Any], let status = value["status"] as? String else
                {
                    return
                }
                
                if status == "success"
                {
                    completion()
                }
                
        }
    }
    
    func uploadCustomLogsReceipts(_ id:String, screenMode:InternalNoteMode, _ message: String, _ completion:@escaping ()-> Void)
    {
        var prop:[String: String] = ["log_comment":message,
                                     "emp_id": DrConstants.kAppDelegate.loginUser.id!,
                                            ]
        
        var urlString = String()
        if screenMode == .rma
        {
            prop["ticket_id"] = id
            urlString = "\(IVE_URLConstant.kPostRma_Log)"
        }
        else if screenMode == .ir
        {
            prop["inventory_id"] = id
            urlString = "\(IVE_URLConstant.kPostInventory_Log)"
        }
        
        
        Alamofire.request(
            URL(string: "\(urlString)")!,
            method: .post,
            parameters: prop)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                guard let value = response.result.value as? [String: Any], let status = value["status"] as? String else
                {
                    print("Malformed data received from fetchAllRooms service")
                    return
                }
                
                if status == "success"
                {
                    completion()
                }
                
        }
    }
    
    
    func profileUpdate(properties:[String: String], completion:@escaping ()->Void)
    {
        print("\n prop = \(properties)")
        
        Alamofire.request(
            URL(string: "\(IVE_URLConstant.kUsersUpdate)\(DrConstants.kAppDelegate.loginUser.id!)")!,
            method: .post,
            parameters: properties)
            .validate()
            .responseJSON { (response) -> Void in
                
                print("response.result.value = \(String(describing: response.result.value))")
                
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                guard let value = response.result.value as? [String: Any], let status = value["status"] as? String else
                {
                    print("Malformed data received from fetchAllRooms service")
                    return
                }
                
                if status == "success"
                {
                    completion()
                }
        }

    }
    
    
    func getLoginUserProfile(completion:@escaping (_ user: IVE_User?)-> Void)
    {
        Alamofire.request(
            URL(string: "\(IVE_URLConstant.kUserProfile)\(DrConstants.kAppDelegate.loginUser.id!)")!,
            method: .get,
            parameters: nil)
            .validate()
            .responseJSON { (response) -> Void in
                
                print("response.result.value = \(String(describing: response.result.value))")
                
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                guard let value = response.result.value as? [String: Any], let status = value["status"] as? String else
                {
                    print("Malformed data received from fetchAllRooms service")
                    return
                }
                
                if status == "success"
                {
                    //completion()
                    
                    if let dataDict = value["data"] as? [String: Any]
                    {
                        let userStruct = IVE_User.init(dict: dataDict)
                        completion(userStruct)
                    }
                }
                else
                {
                    completion(nil)
                }
        }
    }
    
    
    func itemReceiveUpdate(properties:[String: String], completion:@escaping ()->Void)
    {
        print("\n prop = \(properties)")
        
        Alamofire.request(
            URL(string: "\(IVE_URLConstant.kItemReceiveUpdate)")!,
            method: .post,
            parameters: properties)
            .validate()
            .responseJSON { (response) -> Void in
                
                print("response.result.value = \(String(describing: response.result.value))")
                
                guard response.result.isSuccess else
                {
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                guard let value = response.result.value as? [String: Any], let status = value["status"] as? String else
                {
                    print("Malformed data received from fetchAllRooms service")
                    return
                }
                
                if status == "success"
                {
                    completion()
                }
        }
        
    }
    
    func addNewvendor(properties:[String: String], completion:@escaping ()->Void)
    {
        Alamofire.request(
            URL(string: "\(IVE_URLConstant.kAddNewVendor)")!,
            method: .post,
            parameters: properties)
            .validate()
            .responseJSON { (response) -> Void in
                
                print("response.result.value = \(String(describing: response.result.value))")
                
                guard response.result.isSuccess else
                {
                    return
                }
                
                guard let value = response.result.value as? [String: Any], let status = value["status"] as? String else
                {
                    return
                }
                
                if status == "success"
                {
                    completion()
                }
          }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
