//
//  ReturnViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 24/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit
import SkeletonView

class ReturnViewController: UIViewController, ReturnSearchProtocol, RadioButtonProtocol, ReturnDelegateProtocol
{
    @IBOutlet weak var view_gradientBorder:UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let returnViewManager = ReturnViewManager()
    var dataSource = ReturnDataSource()
    var delegate = ReturnDelegate()
    
    var returnSearchDelegate = ReturnSearchDelegate()
    var savedDataArray =  [Return]()
    var printDataArray =  [Return]()
    var doneButton : UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Returns"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]

        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        configureNavigationBar()
        configureSearchBar()
        
        self.view_gradientBorder.addHorizontalGradientColor(leftColor: ColorConstant.leftRedColor, and: ColorConstant.rightRedColor)
        
        self.edgesForExtendedLayout = []
        self.tableView.register(UINib.init(nibName: "ReturnCell", bundle: nil), forCellReuseIdentifier: "ReturnCell")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 168.0;
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        JustHUD.shared.showInView(view: self.view)
        self.returnViewManager.getReturnList(completion: { (list:[Return]?) in
            
            if let _ = list
            {
                JustHUD.shared.hide()
                self.savedDataArray = list!
                
                print("list= \(String(describing: list))")
                self.searchBar.delegate = self.returnSearchDelegate
                self.returnSearchDelegate.returnDelegate = self
                
                
                self.dataSource.returnList = list!
                self.dataSource.radioButtonDelegate = self
                
                self.delegate.returnDelegate = self
                self.delegate.searchBar = self.searchBar
                
                self.tableView.dataSource = self.dataSource
                self.tableView.delegate = self.delegate
                self.tableView.reloadData()
            }
        })
    }
    
    func configureNavigationBar()
    {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "backbutton_icon"), target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
        
        
        let printerButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "printer_icon"), target: self, action: #selector(printerButtonTapped))
        
        let scannerButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "scanner"), target: self, action: #selector(scannerButtonTapped))

        self.navigationItem.rightBarButtonItems = [printerButton, scannerButton]
        
        if (DrConstants.kAppDelegate.loginUser.role == IVEUserRole.kAdmin ||   DrConstants.kAppDelegate.loginUser.access.contains(IVEAccess.kRma_Print))
        {
            printerButton.isEnabled = true
        }
        else
        {
            printerButton.isEnabled = false
        }
        
    }
    
    //MARK:- NavigationBar Button Action
    @objc func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func scannerButtonTapped()
    {
        print("#function = \(#function)")
        
        let scannerVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "ScannerViewController") as! ScannerViewController
        self.navigationController?.pushViewController(scannerVC, animated: true)
    }
    
    
    @objc func printerButtonTapped()
    {
        print("#function = \(#function)")
        
        let cancelButton = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
        cancelButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = cancelButton
        
        self.doneButton = UIBarButtonItem.init(barButtonSystemItem: .done , target: self, action: #selector(doneButtonPressed))
        self.doneButton.tintColor = UIColor.white
        self.doneButton.isEnabled = false
        self.navigationItem.rightBarButtonItem = self.doneButton
        
        self.dataSource.screenMode = .PRINT
        self.tableView.reloadData()
    }
    
    @objc func cancelButtonPressed()
    {
        print("#function = \(#function)")
        configureNavigationBar()
        self.printDataArray.removeAll()
        self.dataSource.printList = self.printDataArray
        self.dataSource.screenMode = .NONE

        self.tableView.reloadData()
    }
    
    @objc func doneButtonPressed()
    {
        print("#function = \(#function)")
        print("Start Process To Print Items On Printer")
        
        if self.printDataArray.count > 0
        {
            WirelessPrinterManager.shared.openPrinterPreview(printDocArray: self.printDataArray, viewController: self)
        }
        
        
    }
    
    func configureSearchBar()
    {
        self.searchBar.barTintColor =  ColorConstant.blueFillColor
        let attributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
    }
    
    //MARK:- ReturnSearchProtocol
    func didFilterWithSearchText(searchText: String)
    {
        print("searchText Main= \(searchText)")
        
        if searchText.count > 0
        {
            let filteredArray = self.savedDataArray.filter { (retObj:Return) -> Bool in
                
                if (retObj.brand.lowercased().contains(searchText.lowercased()) || retObj.rma.lowercased().contains(searchText.lowercased()))
                {
                    return true
                }
                
                return false
            }
            //print("filteredArray= \(filteredArray)")
            self.dataSource.returnList = filteredArray
        }
        else
        {
            self.dataSource.returnList = self.savedDataArray
        }
        
        self.tableView.reloadData()

    }
    
    func didPressSearchBarCancelButton()
    {
        print("didPressSearchBarCancelButton")
        
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
        self.searchBar.showsCancelButton = false
        self.searchBar.resignFirstResponder()
    }
    
    
    //MARK:- RadioButtonProtocol
    func didSelectRadioButton(cell:ReturnCell)
    {
        //print("cell = \(cell)   and \n  DS = \(cell.dataStruct)")
        let isContains = self.printDataArray.contains { (obj:Return) -> Bool in
            
           if obj.rma == cell.dataStruct.rma
           {
              return true
           }
            
            return false
        }
        
        if isContains == true
        {
            print("Contains")
            let filteredArr = self.printDataArray.filter({ (obj:Return) -> Bool in
                
                if obj.rma == cell.dataStruct.rma
                {
                    return false
                }
                
                return true
            })
            
            self.printDataArray = filteredArr
        }
        else
        {
            print("Not Contains")
            self.printDataArray.append(cell.dataStruct)
        }
        
        
        if self.printDataArray.count > 0
        {
            self.doneButton.isEnabled = true
        }
        else
        {
            self.doneButton.isEnabled = false
        }
        
        self.dataSource.printList = self.printDataArray
        self.tableView.reloadData()
    }

    //MARK:- ReturnDelegateProtocol
    func didSelectCell(indexPath: IndexPath)
    {
        if (DrConstants.kAppDelegate.loginUser.role == IVEUserRole.kAdmin || DrConstants.kAppDelegate.loginUser.access.contains(IVEAccess.kRma_Detail))
        {
            let dataStruct = self.dataSource.returnList[indexPath.row]
            JustHUD.shared.showInView(view: self.view)
           NetworkManager.sharedManager.getRmaDetails(rma: dataStruct.rma) { (returnStruct) in
            JustHUD.shared.hide()
            if let _ = returnStruct
            {
                let detailsVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                detailsVC.dataStruct = returnStruct
                self.navigationController?.pushViewController(detailsVC, animated: true)
            }
          }
        }
        else
        {
            self.showAlert(message: "You have no access of RMA Detail")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
