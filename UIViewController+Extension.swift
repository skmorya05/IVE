//
//  UIViewController+Extension.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 14/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func showAlert(message:String)
    {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

