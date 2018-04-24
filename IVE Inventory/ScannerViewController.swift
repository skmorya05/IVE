//
//  ScannerViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 04/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation
import UIKit

class ScannerViewController: UIViewController {
    
    let scanner = ScanManager.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "QRCode Scanner"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.tintColor = ColorConstant.blueFillColor
        
        self.edgesForExtendedLayout = []
        scanner.showScanner(self.view) { (code, errorMsg) in
            
            if let _ = code
            {
                NetworkManager.sharedManager.getRmaDetails(rma: code!, completion: { (returnStruct:Return?) in
                    
                    if let _ = returnStruct
                    {
                        let empID = DrConstants.kAppDelegate.loginUser.id!
                        let prop = ["ticket_id": returnStruct?.id!, "emp_id": empID, "value":"Yes"] as! [String: String]
                        
                        NetworkManager.sharedManager.itemReceiveUpdate(properties: prop, completion: {
                            let detailsVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                            detailsVC.dataStruct = returnStruct
                            self.navigationController?.pushViewController(detailsVC, animated: true)
                        })
                    }
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
