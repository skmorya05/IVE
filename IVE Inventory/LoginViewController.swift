//
//  LoginViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 29/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit
import Material

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


    
    override func viewDidLoad() {
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
        // authenticationWithTouchID()
        let regVC = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(regVC, animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
