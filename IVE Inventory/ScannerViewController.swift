//
//  ScannerViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 08/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class ScannerViewController: UIViewController {

    let scanner = ScanManager.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "QRCode Scanner"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.tintColor = ColorConstant.blueFillColor
        
        self.edgesForExtendedLayout = []
        scanner.showScanner(self) { (code, errorMsg) in
            
            if let _ = code
            {
                NetworkManager.sharedManager.getRmaDetails(rma: code!, completion: { (returnStruct:Return?) in
                    
                    if let _ = returnStruct
                    {
                        let detailsVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                        detailsVC.dataStruct = returnStruct
                        self.navigationController?.pushViewController(detailsVC, animated: true)
                    }
                })
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
