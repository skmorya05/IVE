//
//  RegisterViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 29/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit
import Material

enum PhotoSource {
    case Camera
    case Gallery
    case None
}

class RegisterViewController: UIViewController, UITextFieldDelegate
{

    @IBOutlet weak var view_gradientBorder:UIView!
    @IBOutlet weak var btn_userImageView: UIButton!

    @IBOutlet weak var tf_UserName: TextField!
    @IBOutlet weak var tf_Password: TextField!
    @IBOutlet weak var tf_Email: TextField!
    @IBOutlet weak var tf_initial: TextField!
    @IBOutlet weak var btn_SignUp: UIButton!

    @IBOutlet weak var btn_AlreadyhasAccount: UIButton!
    @IBOutlet weak var btn_SignIn: UIButton!
    
    var selectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
        self.title = "Sign In"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
        
        self.view_gradientBorder.addHorizontalGradientColor(leftColor: ColorConstant.leftRedColor, and: ColorConstant.rightRedColor)

    }
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    func setUpViews()
    {
        //Setup Text Fields
        tf_UserName.dividerActiveColor = UIColor.getColorWithRGB(color: [240,240,240])
        tf_UserName.placeholderActiveColor = UIColor.getColorWithRGB(color: [154,154,154])
        
        tf_Password.dividerActiveColor = UIColor.getColorWithRGB(color: [240,240,240])
        tf_Password.placeholderActiveColor = UIColor.getColorWithRGB(color: [154,154,154])
        
        tf_Email.dividerActiveColor = UIColor.getColorWithRGB(color: [240,240,240])
        tf_Email.placeholderActiveColor = UIColor.getColorWithRGB(color: [154,154,154])
        
        tf_initial.dividerActiveColor = UIColor.getColorWithRGB(color: [240,240,240])
        tf_initial.placeholderActiveColor = UIColor.getColorWithRGB(color: [154,154,154])
        
        
        btn_SignUp.roundCorners(radius: 5.0, width: 2.0, color:UIColor.getColorWithRGB(color: [213,213,212]))
        
        self.btn_userImageView.layer.cornerRadius = self.btn_userImageView.frame.size.width/2
        self.btn_userImageView.clipsToBounds = true
        
        //Setup Buttons
        btn_AlreadyhasAccount.setTitleColor(grayTextColor, for: .normal)
        btn_SignIn.setTitleColor(blueTextColor, for: .normal)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func tagGuestureButtonTapped(tapGuesture: UITapGestureRecognizer)
    {
        for view in self.view.subviews
        {
            if view .isKind(of: UITextField.self)
            {
                let tf = view as! UITextField
                tf.resignFirstResponder()
            }
        }
    }
    
    @IBAction func btnTapped_selectUserImage(sender: UIButton)
    {
        let alertController = UIAlertController.init(title: "Choose Image", message: "", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction.init(title: "Camera", style: .default) { (action:UIAlertAction) in
            
            self.openSourceToChoosePhotos(source: .Camera)
        }
        alertController.addAction(cameraAction)
        
        let galleryAction = UIAlertAction.init(title: "Gallery", style: .default) { (action:UIAlertAction) in
            
            self.openSourceToChoosePhotos(source: .Gallery)
        }
        alertController.addAction(galleryAction)

        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
        }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func openSourceToChoosePhotos(source: PhotoSource)
    {
        if source == .Camera
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = true
                imagePicker.delegate = self
                present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                self.showAlert(message: "Camera not available")
            }
        }
        else if source == .Gallery
        {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
            {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                imagePicker.delegate = self
                present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                self.showAlert(message: "Gallery not available")
            }
        }
    }
    
    @IBAction func btnTapped_signIn(sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTapped_signUp(sender: UIButton)
    {
        
        self.updateUserImage(id:"28")
        
       /* guard let username = tf_UserName.text else { return }
        guard let password = tf_Password.text else { return }
        guard let email = tf_Email.text else { return }
        guard let initial = tf_initial.text else { return }
        
        if username.count == 0
        {
            showAlert(message: "Please enter username")
        }
        else if password.count == 0
        {
            showAlert(message: "Please enter password")
        }
        else if password.count < 4 && password.count > 6
        {
            showAlert(message: "Password must be  four to six digits")
        }
        else if email.count == 0
        {
            showAlert(message: "Please enter email")
        }
        else if initial.count == 0
        {
            showAlert(message: "Please enter initial")
        }
        else
        {
            
            let properties:[String: String] = [IVE_KeyConstant.kName: username,
                              IVE_KeyConstant.kEmail: email,
                              IVE_KeyConstant.kPassword: password,
                              IVE_KeyConstant.kInitial: initial,
                              ]
           
            NetworkManager.sharedManager.registerUser(properties: properties, completion: { (_ user:IVE_User?) in
                
                guard let _ = user else { return }
                
                if let userId = user?.id
                {
                    DrConstants.kUser_Default.set(userId, forKey: IVE_KeyConstant.kId)
                    DrConstants.kUser_Default.synchronize()
                    DrConstants.kAppDelegate.loginUser = user!
                    
                    //let menuVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                    //self.navigationController?.pushViewController(menuVC, animated: true)
                    
                    if self.selectedImage != nil
                    {
                        self.updateUserImage(id:userId)
                    }
                }
            })
        } */
    }

    
    func updateUserImage(id:String)
    {
        if let imageData:Data = UIImageJPEGRepresentation(self.selectedImage, 1.0)
        {
            NetworkManager.sharedManager.uploadImage(imageData, id, nil, withCompletion: { _,_ in })
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
