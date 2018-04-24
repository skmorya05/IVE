//
//  InventoryReceiptViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 08/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class InventoryReceiptViewController: UIViewController, MenuSelectionProtocol, ReturnSearchProtocol, InternalProtocols
{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var view_gradientBorder:UIView!
    @IBOutlet weak var inventoryTableView: UITableView!

    var dataSource  = DataSource_InventoryReceipt()
    var delegate = Delegate_InventoryReceipt()
    var returnSearchDelegate = ReturnSearchDelegate()

    
    let inventoryReceiptManager = InventoryReceiptManager()
    var globalReceipts:[IVEReceipt]!
    
    //MARK:- View life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.edgesForExtendedLayout = []

        
        self.inventoryTableView.register(UINib.init(nibName: "InventoryReceiptCell", bundle: nil), forCellReuseIdentifier: "InventoryReceiptCell")
        
        self.inventoryTableView.estimatedRowHeight =  191.0
        self.inventoryTableView.rowHeight = UITableViewAutomaticDimension
        
        configureNavigationBar()
        configureSearchBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.searchBar.resignFirstResponder()
        self.pageRefresh()
    }
    
    func pageRefresh()
    {
        JustHUD.shared.showInView(view: self.view)
        inventoryReceiptManager.getReceiptList { (list) in
            JustHUD.shared.hide()
            
            if let _ = list
            {
                self.globalReceipts = list
                
                if self.searchBar.text?.count == 0
                {
                    self.delegate.receipts = list
                    self.delegate.menuBtnDelegate = self
                    
                    self.dataSource.receipts = list
                    
                    self.inventoryTableView.dataSource = self.dataSource
                    self.inventoryTableView.delegate = self.delegate
                    
                    //For Searching
                    self.searchBar.delegate = self.returnSearchDelegate
                    self.returnSearchDelegate.returnDelegate = self
                    
                    self.inventoryTableView.reloadData()
                }
                else
                {
                    self.didFilterWithSearchText(searchText: self.searchBar.text!)
                }
            }
        }
    }

    func configureNavigationBar()
    {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "backbutton_icon"), target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.title = "Inventory Receipt"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
        
        let printerButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "printer_icon"), target: self, action: #selector(printerButtonTapped))
        
        let scannerButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "scanner"), target: self, action: #selector(scannerButtonTapped))
        
        self.navigationItem.rightBarButtonItems = [printerButton, scannerButton]
        
        
        if (DrConstants.kAppDelegate.loginUser.role == IVEUserRole.kAdmin || DrConstants.kAppDelegate.loginUser.access.contains(IVEAccess.kRma_Print))
        {
            printerButton.isEnabled = true
        }
        else
        {
            printerButton.isEnabled = false
        }
        
        self.view_gradientBorder.addHorizontalGradientColor(leftColor: ColorConstant.leftRedColor, and: ColorConstant.rightRedColor)
    }
    
    
    func configureSearchBar()
    {
        self.searchBar.barTintColor =  ColorConstant.blueFillColor
        let attributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
    }
    
    //MARK: Navigation Bar Button Action
    @objc func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func printerButtonTapped()
    {
        //print("#function = \(#function)")
        //WirelessPrinterManager.shared.openPrinterPreview(printDocArray: [self.dataStruct], viewController: self)
    }
    
    @objc func scannerButtonTapped()
    {
        let bottomTrayVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "BottomTrayViewController") as! BottomTrayViewController
        bottomTrayVC.delegate_InternalProtocol = self
        bottomTrayVC.isCameraOnly = true
        self.navigationController?.pushViewController(bottomTrayVC, animated: true)
    }
    
    //MARK: Delegate Methods
    func didSelectMenuButton(indexPath:IndexPath)
    {
        print("#function = \(#function)")
        
        let detailsVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "InventoryReceiptDetailsVC") as! InventoryReceiptDetailsVC
        detailsVC.iveReceipt = self.dataSource.receipts[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func didScrollTableView()
    {
        self.searchBar.resignFirstResponder()
    }
    
    //MARK:- ReturnSearchProtocol
    func didFilterWithSearchText(searchText: String)
    {
        print("searchText Main= \(searchText)")
        
        if searchText.count > 0
        {
            let filteredArray = self.globalReceipts.filter { (retObj:IVEReceipt) -> Bool in
                
                if (retObj.name.lowercased().contains(searchText.lowercased()) || retObj.receipt_no.lowercased().contains(searchText.lowercased()))
                {
                    return true
                }
                
                return false
            }

            self.dataSource.receipts = filteredArray
        }
        else
        {
            self.dataSource.receipts = self.globalReceipts
        }
        
        self.inventoryTableView.reloadData()
        
    }
    
    func didPressSearchBarCancelButton()
    {
        print("didPressSearchBarCancelButton")
        
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
        self.searchBar.showsCancelButton = false
        self.searchBar.resignFirstResponder()
        
        self.dataSource.receipts = self.globalReceipts
        self.delegate.receipts = self.globalReceipts
        
        self.inventoryTableView.reloadData()
    }
    
    //MARK: - ------------InternalProtocols-----------
    func didTappedInternalProtocols()
    {
        self.pageRefresh()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
  

}
