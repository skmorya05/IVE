//
//  DetailsViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 25/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, InternalProtocols
{
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var view_gradientBorder:UIView!
    
    var operation = String()
    var curior = String()


    var dataStruct: Return!
    var views: [UIView]!
    
    var dataSource = DataSource_DetailsVC()
    var delegate = Delegate_DetailsVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.edgesForExtendedLayout = []

       //configureView()
       configureNavigationBar()
        
       tableView.register(UINib.init(nibName: "RmaDetailCell", bundle: nil), forCellReuseIdentifier: "RmaDetailCell")
       tableView.register(UINib.init(nibName: "RmaContainerCell", bundle: nil), forCellReuseIdentifier: "RmaContainerCell")
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
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        
        self.dataSource.vc = self
        self.dataSource.rmaStruct = self.dataStruct
        
        tableView.dataSource = self.dataSource
        tableView.delegate = self.delegate
        tableView.estimatedRowHeight = 277.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func configureView()
    {
       /* self.view_gradientBorder.addHorizontalGradientColor(leftColor: ColorConstant.leftRedColor, and: ColorConstant.rightRedColor)
        self.view_container.addShadow()
        
        self.views = [UIView]()
        guard let invView = Bundle.main.loadNibNamed("InventoryView", owner: self, options: nil)?.first as? InventoryView else { return }
        invView.frame = CGRect.init(x: 0, y: 0, width:ScreenSize.SCREEN_WIDTH-10 , height: self.view_container.frame.height)
        self.views.append(invView)
        
        guard let cusView = Bundle.main.loadNibNamed("CustomerView", owner: self, options: nil)?.first as? CustomerView else { return }
        cusView.frame = CGRect.init(x: 0, y: 0, width:ScreenSize.SCREEN_WIDTH-10 , height: self.view_container.frame.height)
        self.views.append(cusView)
        
        for v in self.views
        {
            self.view_container.addSubview(v)
        }
        
        self.view_container.bringSubview(toFront: self.views[0])
        self.updateContainerFrame(view:self.views[0])
 */
        /*
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
        
        self.btn_Save.setTitleColor(ColorConstant.navBarColor, for: .normal) */
    }
    
    @IBAction func segmentButtonTapped(sender:UISegmentedControl)
    {
//        self.view_container.bringSubview(toFront: self.views[sender.selectedSegmentIndex])
//        self.updateContainerFrame(view: self.views[sender.selectedSegmentIndex])
    }
    
    
    
    func updateContainerFrame(view:UIView)
    {
//        let origin = self.view_container.frame.origin
//        let size =   view.frame.size
//
//        self.view_container.frame = CGRect.init(x: origin.x, y: origin.y, width: size.width, height: size.height)
//        self.view_container.layoutIfNeeded()
//        self.view.layoutIfNeeded()
//        self.view.layoutSubviews()
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
    
    @IBAction func selectOperationOnRMA(sender:UIButton)
    {
        
    }
    
    
    
    @IBAction func manageButtonsState(btn_Radio:UIButton)
    {
        
    }
    
    
    func makeUpdateRadioButtons(isActive:Bool)
    {
    
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
    
    //MARK:- InternalProtocols
    func didTappedInternalProtocols()
    {
        let internalVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "InternalNotesViewController") as! InternalNotesViewController
        internalVC.id = self.dataStruct.id!
        internalVC.irNote_Mode = .rma
        self.navigationController?.pushViewController(internalVC, animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
