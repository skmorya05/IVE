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


extension RegisterViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let _ = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            // Use editedImage Here
        }
        
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            // Use originalImage Here
            self.selectedImage = originalImage
            self.btn_userImageView.setBackgroundImage(self.selectedImage, for: .normal)
            self.btn_userImageView.roundCorners(radius: self.btn_userImageView.frame.width/2)
            
        }
        else
        {
            print("Image Not Found")
        }
        
        picker.dismiss(animated: true)
    }
}
