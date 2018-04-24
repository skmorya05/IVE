//
//  VendorManager.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 23/04/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation

class VendorManager: NSObject
{
    static var sharedManager = VendorManager()
    
    func getVendorsList(completion:@escaping (_ list:[IVEVendor])->Void)
    {
        NetworkManager.sharedManager.getVendorsList { (vendors:[[String: Any]]?) in
            
            var vendorList = [IVEVendor]()
            if let _ = vendors
            {
                print("\n \n vendorsList = \(String(describing: vendors?.count))")
                for vendorItem in vendors!
                {
                    let vendor = IVEVendor.init(dict: vendorItem)
                    vendorList.append(vendor)
                }
                
                DispatchQueue.main.async {
                    completion(vendorList)
                }
            }
        }
    }
}
