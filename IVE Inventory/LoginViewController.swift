//
//  LoginViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 29/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit
import Material
import Alamofire

let grayTextColor = UIColor.getColorWithRGB(color: [190,189,190])
let darkGrayBorderColor = UIColor.getColorWithRGB(color: [213,213,212])
let blueTextColor = UIColor.getColorWithRGB(color: [0,0,39])


class LoginViewController: UIViewController, UITextFieldDelegate
{
    //Outlets
    @IBOutlet weak var view_gradientBorder:UIView!

    @IBOutlet weak var tf_UserName: TextField!
    @IBOutlet weak var tf_Password: TextField!
    @IBOutlet weak var btn_Login: UIButton!
    @IBOutlet weak var btn_rememberMe: UIButton!
    
    @IBOutlet weak var btn_forgotPassword: UIButton!
    @IBOutlet weak var btn_SignUp: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpViews()
        
        self.title = "Sign In"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
        
        self.view_gradientBorder.addHorizontalGradientColor(leftColor: ColorConstant.leftRedColor, and: ColorConstant.rightRedColor)

    }

    func setUpViews()
    {
        //Setup Text Fields
        tf_UserName.dividerActiveColor = UIColor.getColorWithRGB(color: [240,240,240])
        tf_UserName.placeholderActiveColor = UIColor.getColorWithRGB(color: [154,154,154])
        
        tf_Password.dividerActiveColor = UIColor.getColorWithRGB(color: [240,240,240])
        tf_Password.placeholderActiveColor = UIColor.getColorWithRGB(color: [154,154,154])
        
        btn_rememberMe.backgroundColor = UIColor.white
        btn_rememberMe.tintColor = UIColor.getColorWithRGB(color: [213,213,212])
        btn_rememberMe.setBackgroundImage(UIImage.init(named: "remember_Uncheck"), for: .normal)
        btn_rememberMe.setBackgroundImage(UIImage.init(named: "remember_check"), for: .selected)
        btn_rememberMe.imageView?.contentMode = .scaleAspectFit

        
        
        btn_Login.roundCorners(radius: 5.0, width: 2.0, color:UIColor.getColorWithRGB(color: [213,213,212]))
        
        //Setup Buttons
        btn_forgotPassword.setTitleColor(grayTextColor, for: .normal)
        btn_SignUp.setTitleColor(blueTextColor, for: .normal)
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
    
    @IBAction func rememberMeButtonTapped(sender: UIButton)
    {
           if btn_rememberMe.isSelected
           {
               btn_rememberMe.isSelected = false
           }
            else
           {
                btn_rememberMe.isSelected = true
           }
    }
    
    @IBAction func loginButtonTapped(sender: UIButton)
    {
        guard let username = tf_UserName.text else
        {
            return
        }
        
        guard let password = tf_Password.text else
        {
            return
        }
        
        
        if username.count == 0
        {
            self.showAlert(message: "Please enter user name")
        }
        else if password.count == 0
        {
            self.showAlert(message: "Please enter password")
        }
        else
        {
            JustHUD.shared.showInView(view: self.view)
            let dict = [IVE_KeyConstant.kName: username, IVE_KeyConstant.kPassword: password]
            NetworkManager.sharedManager.getLoginDetails(dict: dict, completion: { (user:IVE_User?) in
                
                JustHUD.shared.hide()
                print("loginDetails = \(String(describing: user))")
                
                if let userId = user?.id
                {
                    DrConstants.kUser_Default.set(userId, forKey: IVE_KeyConstant.kId)
                    DrConstants.kUser_Default.synchronize()
                    DrConstants.kAppDelegate.loginUser = user!
                    
                    let menuVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                    self.navigationController?.pushViewController(menuVC, animated: true)
                    
                }
            })
        }
 
       //testImage()
        
    }
    
    func testImage()
    {
          let image1 = UIImage.init(named: "1.jpeg")!
         let image2 = UIImage.init(named: "2.jpeg")!
         let image3 = UIImage.init(named: "3.jpeg")!
         
         let imagesList:[UIImage] = [image1, image2, image3]
         
         var imageStrArr = [String]()
         for image in imagesList
         {
             if let base64String = image.base64(format: .JPEG(1.0))
             {
                imageStrArr.append(base64String)
                print("base64String = \(base64String)")
             }
         }
         
         Alamofire.request(
         URL(string: "http://stackup.mobi/220electronics/image_upload.php")!,
         method: .post,
         parameters: ["images":imageStrArr])
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
         
         print("\n response.result.value = \(response.result.value)")
         }
        
    }
    
    
    @IBAction func forgotYourPasswordButtonTapped(sender: UIButton)
    {
        
    }

    @IBAction func signUpButtonTapped(sender: UIButton)
    {
        let regVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        regVC.pageDisplayMode = .register
        self.navigationController?.pushViewController(regVC, animated: true)
    }

    
    //MARK: - UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
