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

enum RegisterPageDisplayMode {
    case register
    case profileUpdate
    case none
}

class RegisterViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    @IBOutlet weak var view_gradientBorder:UIView!
    @IBOutlet weak var btn_userImageView: UIButton!
    @IBOutlet weak var imageView_userImageView: UIImageView!

    @IBOutlet weak var tf_UserName: TextField!
    @IBOutlet weak var tf_Password: TextField!
    @IBOutlet weak var tf_Email: TextField!
    @IBOutlet weak var tf_initial: TextField!
    @IBOutlet weak var btn_SignUp: UIButton!

    @IBOutlet weak var btn_AlreadyhasAccount: UIButton!
    @IBOutlet weak var btn_SignIn: UIButton!
    
    @IBOutlet weak var view_container_btn_sign: UIView!
    
    var imagePicker:UIImagePickerController!
    var selectedImage: UIImage!
    var pageDisplayMode: RegisterPageDisplayMode = .none
    var isProfileUpdate = false
    
    //MARK: ------------Methods--------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
        self.title = "Sign In"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
        
        self.view_gradientBorder.addHorizontalGradientColor(leftColor: ColorConstant.leftRedColor, and: ColorConstant.rightRedColor)

        if pageDisplayMode == .profileUpdate
        {
            self.title = "Profile Update"
            self.navigationItem.hidesBackButton = false
            let backButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "backbutton_icon"), target: self, action: #selector(self.goBack))
            self.navigationItem.leftBarButtonItem = backButton
            
            self.btn_SignUp.setTitle("Update", for: .normal)
            self.view_container_btn_sign.isHidden = true
            
            getUserProfile()
        }
    }
    
    @objc func goBack()
   {
       self.navigationController?.popViewController(animated: true)
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
                
                self.isProfileUpdate = true
            }
        }
    }
    
    //MARK:----------------Webservice----------------
    func getUserProfile()
    {
        JustHUD.shared.showInView(view: self.view)
        NetworkManager.sharedManager.getLoginUserProfile { (user) in
            JustHUD.shared.hide()
            if let _ = user
            {
                if let loginUser = user
                {
                    var imageStr = String()
                    if loginUser.photo.count != 0
                    {
                        imageStr = "\(DrConstants.kBaseUrlImage)\(loginUser.photo!)"
                        DispatchQueue.global().async {
                            do {
                                let url = URL(string:imageStr)!
                                let data = try Data.init(contentsOf: url)
                                DispatchQueue.main.async {
                                    if self.selectedImage == nil
                                    {
                                        let image = UIImage.init(data: data)!
                                        print("image = \(String(describing: image))")
                                        
                                        self.btn_userImageView.setImage(image, for: .normal)
                                        self.btn_userImageView.layer.cornerRadius = self.btn_userImageView.frame.size.width/2
                                        self.btn_userImageView.clipsToBounds = true
                                    }
                                }
                            }
                            catch
                            {
                                
                            }
                        }
                    }
                    else
                    {
                        if self.selectedImage == nil
                        {
                           self.btn_userImageView.setBackgroundImage(UIImage.init(named: imageStr) , for: .normal)
                        }
                    }
                    
                    self.tf_UserName.text = loginUser.name
                    self.tf_Password.text = "XXXXXXXXXXX"
                    self.tf_Email.text = loginUser.email
                    self.tf_initial.text = loginUser.initial
                }
            }
        }
    }
    
    //MARK:-------------Button Actions--------------
    @IBAction func btnTapped_selectUserImage(sender: UIButton)
    {
        DispatchQueue.main.async {
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
            
            if let popoverPresentationController = alertController.popoverPresentationController
            {
                popoverPresentationController.sourceView = self.view
                popoverPresentationController.sourceRect = CGRect(x: self.view.center.x, y:self.view.center.y, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
            }
            
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func openSourceToChoosePhotos(source: PhotoSource)
    {
        if source == .Camera
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                self.imagePicker = UIImagePickerController()
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = true
                self.imagePicker.delegate = self
                present(self.imagePicker, animated: true, completion: nil)
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
                self.imagePicker = UIImagePickerController()
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.allowsEditing = true
                self.imagePicker.delegate = self
                present(self.imagePicker, animated: true, completion: nil)
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
        guard let username = tf_UserName.text else { return }
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
        else if self.selectedImage == nil
        {
            showAlert(message: "Please select user image")
        }
        else
        {
            registerOrUpdateUserProfile(username: username, email: username, password: password, initial: initial)
        }
    }
    
    func registerOrUpdateUserProfile(username: String, email:  String, password:String, initial:String)
    {
        if self.pageDisplayMode == .register
        {
            let properties:[String: String] = [IVE_KeyConstant.kName: username,
                                               IVE_KeyConstant.kEmail: email,
                                               IVE_KeyConstant.kPassword: password,
                                               IVE_KeyConstant.kInitial: initial,
                                               ]
            JustHUD.shared.showInView(view: self.view)
            NetworkManager.sharedManager.registerUser(properties: properties, completion: { (_ user:IVE_User?) in
                
                JustHUD.shared.hide()
                guard let _ = user else { return }
                
                if let userId = user?.id
                {
                    var userUpdate = user
                    userUpdate?.password = password
                    DrConstants.kUser_Default.set(userId, forKey: IVE_KeyConstant.kId)
                    DrConstants.kUser_Default.synchronize()
                    DrConstants.kAppDelegate.loginUser = userUpdate!
                    
                    if self.selectedImage != nil
                    {
                        self.updateUserImage(id:userId)
                    }
                }
            })
        }
        else if self.pageDisplayMode == .profileUpdate
        {
            let properties:[String: String] = [IVE_KeyConstant.kName: username,
                                               IVE_KeyConstant.kEmail: email,
                                               IVE_KeyConstant.kInitial: initial,
                                               ]
            JustHUD.shared.showInView(view: self.view)
            NetworkManager.sharedManager.profileUpdate(properties: properties, completion: {
                JustHUD.shared.hide()
                if self.selectedImage != nil
                {
                    self.updateUserImage(id:DrConstants.kAppDelegate.loginUser.id!)
                }
                else if self.pageDisplayMode == .register
                {
                    let menuVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                    self.navigationController?.pushViewController(menuVC, animated: true)
                }
                else if self.pageDisplayMode == .profileUpdate
                {
                     self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    func updateUserImage(id:String)
    {
        JustHUD.shared.showInView(view: self.view)
        NetworkManager.sharedManager.uploadImage(self.selectedImage, id, nil, withCompletion: {
            isSuccess in
            
            JustHUD.shared.hide()
             if isSuccess == true
             {
                if self.pageDisplayMode == .register
                {
                    let menuVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                    self.navigationController?.pushViewController(menuVC, animated: true)
                }
                else
                {
                    self.navigationController?.popViewController(animated: true)
                }
             }
        })
    }
    
    //MARK:------------UIImagePickerControllerDelegate---------------
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("\n info = \(info)")
        
        picker.dismiss(animated: true, completion: {
            
            if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            {
                print("\n originalImage = \(originalImage)")

                DispatchQueue.main.async {
                    // Use originalImage Here
                    self.selectedImage = originalImage
                    self.btn_userImageView.roundCorners(radius: self.btn_userImageView.frame.width/2)
                    self.btn_userImageView.setImage(originalImage, for: .normal)
                    self.isProfileUpdate = true
                }
            }
            else
            {
                print("Image Not Found")
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
