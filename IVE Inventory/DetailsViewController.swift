//
//  DetailsViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 25/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit
import MessageUI

enum RMAShareMode {
    case email
    case message
}

class DetailsViewController: UIViewController, InternalProtocols, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate
{
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var view_gradientBorder:UIView!
    
    var operation = String()
    var curior = String()
    
    
    var dataStruct: Return!
    var photos: [[String: String]]!
    var views: [UIView]!
    
    var dataSource = DataSource_DetailsVC()
    var delegate = Delegate_DetailsVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.edgesForExtendedLayout = []
        
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
        
        //Share
        self.title = "RMA#\(self.dataStruct.rma!)"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
        
        let printerButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "printer_icon"), target: self, action: #selector(printerButtonTapped))
        let shareButton = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "Share"), target: self, action: #selector(shareButtonTapped(_:)))
        
        let galleryButton = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "220_clip") , target: self, action: #selector(galleryButtonTapped))
        
        if self.photos.count > 0
        {
            self.navigationItem.rightBarButtonItems = [printerButton, shareButton, galleryButton]
        }
        else
        {
            self.navigationItem.rightBarButtonItems = [printerButton, shareButton]
        }
        
        if (DrConstants.kAppDelegate.loginUser.role == IVEUserRole.kAdmin || DrConstants.kAppDelegate.loginUser.access.contains(IVEAccess.kRma_Print))
        {
            printerButton.isEnabled = true
        }
        else
        {
            printerButton.isEnabled = false
        }
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
    
    @objc func galleryButtonTapped()
    {
        let galleryVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        galleryVC.photos = self.photos
        self.navigationController?.pushViewController(galleryVC, animated: true)
    }
    
    @objc func printerButtonTapped()
    {
        WirelessPrinterManager.shared.openPrinterPreview(printDocArray: [self.dataStruct], viewController: self)
    }
    
    @objc func shareButtonTapped(_ sender:UIBarButtonItem)
    {
        
        let alertController = UIAlertController(title: "Select Share Mode", message: "", preferredStyle: .actionSheet)
        
        let email = UIAlertAction(title: "Email", style: .default) { (action:UIAlertAction) in
            self.openShare(mode: .email)
        }
        
        let message = UIAlertAction(title: "Message", style: .default) { (action:UIAlertAction) in
            self.openShare(mode: .message)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
        }
        
        alertController.addAction(email)
        alertController.addAction(message)
        alertController.addAction(cancel)

        if let popoverPresentationController = alertController.popoverPresentationController
        {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: ScreenSize.SCREEN_WIDTH-100, y:100, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
       
        self.present(alertController, animated: true, completion: nil)
    }
    
    func openShare(mode:RMAShareMode)
    {
        if mode == .email
        {
            if MFMailComposeViewController.canSendMail()
            {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setSubject("RMA Report")
                mail.setMessageBody(self.getMessageToShare(), isHTML: false)
                
                self.present(mail, animated: true, completion: nil)
            }
        }
        else if mode == .message
        {
            if MFMessageComposeViewController.canSendText()
            {
                let message = MFMessageComposeViewController()
                message.messageComposeDelegate = self
                message.body = self.getMessageToShare()
                self.present(message, animated: true, completion: nil)
            }
        }
    }
    
    func getMessageToShare() -> String
    {
        var message = String()
        
        message = "Report"
        
        if let _ = dataStruct.rma
        {
            message = message + "\nRMA = \(dataStruct.rma!)"
        }
        if let _ = dataStruct.rma_type
        {
            message = message + "\nRMA Type = \(dataStruct.rma_type!)"
        }
        if let _ = dataStruct.name
        {
            message = message + "\nName = \(dataStruct.name!)"
        }
        if let _ = dataStruct.address
        {
            message = message + "\nAddress = \(dataStruct.address!)"
        }
        if let _ = dataStruct.company_name
        {
            message = message + "\nCompany Name = \(dataStruct.company_name!)"
        }
        if let _ = dataStruct.brand
        {
            message = message + "\nBrand = \(dataStruct.brand!)"
        }
        if let _ = dataStruct.model
        {
            message = message + "\nModel = \(dataStruct.model!)"
        }
        if let _ = dataStruct.serial
        {
            message = message + "\nSerial = \(dataStruct.serial!)"
        }
        if let _ = dataStruct.orders
        {
            message = message + "\nOrders = \(dataStruct.orders!)"
        }
        
        if let _ = dataStruct.sales_receipt
        {
            message = message + "\nSales Receipt = \(dataStruct.sales_receipt!)"
        }
        if let _ = dataStruct.purchase_date
        {
            message = message + "\nPurchase Date = \(dataStruct.purchase_date!)"
        }
        if let _ = dataStruct.reason
        {
            message = message + "\nReason = \(dataStruct.reason!)"
        }
        if let _ = dataStruct.customer_side
        {
            message = message + "\nCustomer Side = \(dataStruct.customer_side!)"
        }
        if let _ = dataStruct.inventory_side
        {
            message = message + "\nInventory Side = \(dataStruct.inventory_side!)"
        }

        return message
    }
    
    //MARK:------- Protocols Methods--------
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        controller.dismiss(animated: true)
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
