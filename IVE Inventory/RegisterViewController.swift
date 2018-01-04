//
//  RegisterViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 29/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit
import Material

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
        
        tf_Email.dividerActiveColor = UIColor.getColorWithRGB(color: [240,240,240])
        tf_Email.placeholderActiveColor = UIColor.getColorWithRGB(color: [154,154,154])
        
        tf_initial.dividerActiveColor = UIColor.getColorWithRGB(color: [240,240,240])
        tf_initial.placeholderActiveColor = UIColor.getColorWithRGB(color: [154,154,154])
        
        
        btn_SignUp.roundCorners(radius: 5.0, width: 2.0, color:UIColor.getColorWithRGB(color: [213,213,212]))
        
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
    
    @IBAction func rememberMeButtonTapped(sender: UIButton)
    {
        
    }
    
    @IBAction func loginButtonTapped(sender: UIButton)
    {
        // authenticationWithTouchID()
        let regVC = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(regVC, animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
