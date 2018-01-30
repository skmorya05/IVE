//
//  DetailsViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 25/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController
{
    @IBOutlet weak var lbl_rma:UILabel!
    @IBOutlet weak var lbl_serial:UILabel!
    @IBOutlet weak var lbl_brand:UILabel!
    @IBOutlet weak var lbl_model:UILabel!
    @IBOutlet weak var lbl_name:UILabel!
    @IBOutlet weak var lbl_createdate:UILabel!
    @IBOutlet weak var lbl_reason:UILabel!
    @IBOutlet weak var lbl_closedate:UILabel!
    @IBOutlet weak var lbl_closeby:UILabel!
    
    @IBOutlet weak var view_gradientBorder:UIView!
    @IBOutlet weak var view_container:UIView!

    @IBOutlet weak var btn_PutBack_Stock:UIButton!
    @IBOutlet weak var btn_return_back_ToVendor:UIButton!
    @IBOutlet weak var damageProductFileClaim:UIButton!

    
    @IBOutlet weak var btn_UPS:UIButton!
    @IBOutlet weak var btn_FedEx:UIButton!
    @IBOutlet weak var btn_USPS:UIButton!
    @IBOutlet weak var btn_DHL:UIButton!
    
    @IBOutlet weak var lbl_UPS:UILabel!
    @IBOutlet weak var lbl_FedEx:UILabel!
    @IBOutlet weak var lbl_USPS:UILabel!
    @IBOutlet weak var lbl_DHL:UILabel!
    
    
    @IBOutlet weak var btn_Save:UIButton!
    var operation = String()
    var curior = String()


    var dataStruct: Return!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\n \n dataStruct = \(dataStruct)")
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        self.navigationItem.hidesBackButton = true
        self.edgesForExtendedLayout = []
        btn_Save.isEnabled = false
        
        configureView()
        configureNavigationBar()
        loadData()
        damageProductFileClaim.sendActions(for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
    }
    
    func configureNavigationBar()
    {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "backbutton_icon"), target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.title = "RMA#\(self.dataStruct.rma!)"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
        
        let printerButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "printer_icon"), target: self, action: #selector(printerButtonTapped))
        
        if (DrConstants.kAppDelegate.loginUser.role == IVEUserRole.kAdmin || DrConstants.kAppDelegate.loginUser.access.contains(IVEAccess.kRma_Print))
        {
            printerButton.isEnabled = true
        }
        else
        {
            printerButton.isEnabled = false
        }
        
        self.navigationItem.rightBarButtonItem = printerButton
    }
    
    func configureView()
    {
        self.view_gradientBorder.addHorizontalGradientColor(leftColor: ColorConstant.leftRedColor, and: ColorConstant.rightRedColor)
        self.view_container.addShadow()
        
        btn_PutBack_Stock.titleLabel?.adjustsFontSizeToFitWidth = true
        btn_return_back_ToVendor.titleLabel?.adjustsFontSizeToFitWidth = true
        damageProductFileClaim.titleLabel?.adjustsFontSizeToFitWidth = true
        
        btn_PutBack_Stock.titleLabel?.numberOfLines = 0
        btn_return_back_ToVendor.titleLabel?.numberOfLines = 0
        damageProductFileClaim.titleLabel?.numberOfLines = 0
        
        
        btn_Save.layer.borderColor = ColorConstant.navBarColor.cgColor
        btn_Save.layer.borderWidth = 2.0
        
        btn_return_back_ToVendor.contentHorizontalAlignment = .center
        btn_return_back_ToVendor.titleLabel?.textAlignment = .center
        btn_return_back_ToVendor.contentVerticalAlignment = .center
        btn_return_back_ToVendor.titleLabel?.textAlignment = .center
        
        btn_PutBack_Stock.contentHorizontalAlignment = .center
        btn_PutBack_Stock.titleLabel?.textAlignment = .center
        btn_PutBack_Stock.contentVerticalAlignment = .center
        btn_PutBack_Stock.titleLabel?.textAlignment = .center

        damageProductFileClaim.contentHorizontalAlignment = .center
        damageProductFileClaim.titleLabel?.textAlignment = .center
        damageProductFileClaim.contentVerticalAlignment = .center
        damageProductFileClaim.titleLabel?.textAlignment = .center

        
        updateButtonsUI(sender: btn_PutBack_Stock, text:"Put Back in Stock")
        updateButtonsUI(sender: btn_return_back_ToVendor, text:"Return Back to Vendor")
        updateButtonsUI(sender: damageProductFileClaim, text:"Damage Product file a claim")
        
        self.btn_Save.setTitleColor(ColorConstant.navBarColor, for: .normal)
    }
    
    func updateButtonsUI(sender:UIButton,  text:String)
    {
        sender.layer.cornerRadius = 2.0
        sender.clipsToBounds = true
        sender.layer.borderColor = ColorConstant.navBarColor.cgColor
        sender.layer.borderWidth = 2.0
        
        // .Selected
        let attr1 = NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        sender.setAttributedTitle(attr1, for: .selected)
        
        // .Normal
        let attr2 = NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        sender.setAttributedTitle(attr2, for: .normal)

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
         super.viewWillDisappear(true)
    }
    
    //MARK:- NavigationBar Button Action
    @objc func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func printerButtonTapped()
    {
        print("#function = \(#function)")
        WirelessPrinterManager.shared.openPrinterPreview(printDocArray: [self.dataStruct], viewController: self)
    }
    
    
    func loadData()
    {
        self.lbl_rma.text = self.dataStruct.rma
        self.lbl_serial.text = self.dataStruct.serial
        self.lbl_brand.text = self.dataStruct.brand
        self.lbl_model.text = self.dataStruct.model
        self.lbl_name.text = self.dataStruct.name
        self.lbl_createdate.text = self.dataStruct.createdate
        self.lbl_reason.text = self.dataStruct.reason
        self.lbl_closedate.text = self.dataStruct.closedate
        self.lbl_closeby.text = self.dataStruct.closeby
    }
    
    @IBAction func selectOperationOnRMA(sender:UIButton)
    {
        if sender.tag == 0
        {
            updateOperationButtonUI(sender: btn_return_back_ToVendor, isSelected: true)
            updateOperationButtonUI(sender: btn_PutBack_Stock, isSelected: false)
            updateOperationButtonUI(sender: damageProductFileClaim, isSelected: false)
            makeUpdateRadioButtons(isActive: false)
            operation = "btnreturnbacktovendor"
        }
        else if sender.tag == 1
        {
            updateOperationButtonUI(sender: btn_return_back_ToVendor, isSelected: false)
            updateOperationButtonUI(sender: btn_PutBack_Stock, isSelected: true)
            updateOperationButtonUI(sender: damageProductFileClaim, isSelected: false)
            makeUpdateRadioButtons(isActive: false)
            operation = "btnputbackstock"

        }
        else if sender.tag == 2
        {
            updateOperationButtonUI(sender: btn_return_back_ToVendor, isSelected: false)
            updateOperationButtonUI(sender: btn_PutBack_Stock, isSelected: false)
            updateOperationButtonUI(sender: damageProductFileClaim, isSelected: true)
            makeUpdateRadioButtons(isActive: true)
            operation = "damageproductfileclaim"
        }
        
        btn_Save.isEnabled = true
    }
    
    func updateOperationButtonUI(sender:UIButton, isSelected:Bool)
    {
        
        if isSelected
        {
            sender.isSelected = true
            sender.backgroundColor = ColorConstant.saffroFillColor
        }
        else
        {
            sender.isSelected = false
            sender.backgroundColor = ColorConstant.btnBgColor
        }
       
    }
    
    @IBAction func manageButtonsState(btn_Radio:UIButton)
    {
        switch btn_Radio.tag
        {
            case 0:
                btn_UPS.isSelected = true
                btn_FedEx.isSelected = false
                btn_USPS.isSelected = false
                btn_DHL.isSelected = false
                curior = "UPS"

            break
            case 1:
                btn_UPS.isSelected = false
                btn_FedEx.isSelected = true
                btn_USPS.isSelected = false
                btn_DHL.isSelected = false
                curior = "FedEx"
                break
            case 2:
                btn_UPS.isSelected = false
                btn_FedEx.isSelected = false
                btn_USPS.isSelected = true
                btn_DHL.isSelected = false
                curior = "USPS"
                break
            case 3:
                btn_UPS.isSelected = false
                btn_FedEx.isSelected = false
                btn_USPS.isSelected = false
                btn_DHL.isSelected = true
                curior = "DHL"
                break
            default:
                  break
        }
        
        btn_Save.isEnabled = true
    }
    
    
    func makeUpdateRadioButtons(isActive:Bool)
    {
        if isActive
        {
            self.radioButton(sender: btn_UPS, isActive: true)
            self.radioButton(sender: btn_DHL, isActive: true)
            self.radioButton(sender: btn_FedEx, isActive: true)
            self.radioButton(sender: btn_USPS, isActive: true)
        }
        else
        {
            self.radioButton(sender: btn_UPS, isActive: false)
            self.radioButton(sender: btn_DHL, isActive: false)
            self.radioButton(sender: btn_FedEx, isActive: false)
            self.radioButton(sender: btn_USPS, isActive: false)
        }
    }
    
    
    func radioButton(sender:UIButton, isActive:Bool)
    {
        if isActive
        {
            sender.isEnabled = true
        }
        else
        {
            sender.isEnabled = false
        }
    }
    
    
   @IBAction func saveButtonTapped(sender:UIButton)
    {
        let prop:[String: String] =
            ["shipping_method": self.curior,
             "close_date": self.getDate(),
             "by" : "Ray Shah",
             "return_type":self.operation,
             "id" : dataStruct.id
            ]
        
        NetworkManager.sharedManager.updateRma(properties: prop) { (result:Bool) in
            
            if result == true
            {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func getDate() -> String
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        return dateFormatter.string(from: date)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
