//
//  ViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 20/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController, MenuSelectionProtocol, QRCodeReadProtocol, InternalProtocols
{
    //Outlets
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var swipeGSR : UISwipeGestureRecognizer!
    
    let menuArray = ["Vendors", "Returns", "Inventory Receipt", "Setup"]
    
    //properties
    let dataSource = MenuViewDataSource()
    let delegate = MenuViewDelegate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Remove BackButton
        self.navigationItem.hidesBackButton = true
     
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        //Register Cells
        self.collectionView.register(UINib.init(nibName: "MenuMainCell", bundle: nil), forCellWithReuseIdentifier: "MenuMainCell")
        
        let headerView:UINib = UINib(nibName: "HeaderView", bundle: nil)
        self.collectionView.register(headerView, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
        self.collectionView.register(UINib.init(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        
        //Set DataSource and Delegates
        dataSource.menuArray = self.menuArray
        delegate.menuBtnDelegate = self
        
        self.collectionView.dataSource = dataSource
        self.collectionView.delegate = delegate
        
        self.view.addGestureRecognizer(self.swipeGSR)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    func cancelBtnPressed()
    {
        print("\(#function)")
    }
    
    func doneBtnPressed()
    {
        print("\(#function)")
    }
    
    //MARK: - MenuSelectionProtocol
    func didSelectMenuButton(indexPath:IndexPath)
    {
        if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                if (DrConstants.kAppDelegate.loginUser.role == IVEUserRole.kAdmin || DrConstants.kAppDelegate.loginUser.access.contains(IVEAccess.kVendors))
                {
                    let controller = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "VendorsViewController")
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                else
                {
                    self.showAlert(message: "You have no access of Vendors")
                }
            }
            else if indexPath.row == 1
            {
                let controller = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "ReturnViewController")
                self.navigationController?.pushViewController(controller, animated: true)
                /*
                if (DrConstants.kAppDelegate.loginUser.role == IVEUserRole.kAdmin ||   DrConstants.kAppDelegate.loginUser.access.contains(IVEAccess.kReturn))
                {
                    let controller = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "ReturnViewController")
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                else
                {
                    self.showAlert(message: "You have no access of Returns")
                }
                */
            }
            else if indexPath.row == 2
            {
                let InventoryReceiptVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "InventoryReceiptViewController")
                self.navigationController?.pushViewController(InventoryReceiptVC, animated: true)
            }
            else if indexPath.row == 3
            {
                if DrConstants.kAppDelegate.loginUser.role == IVEUserRole.kAdmin
                {
                    let setUpVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "SetUpViewController")
                    self.navigationController?.pushViewController(setUpVC, animated: true)
                }
                else
                {
                    self.showAlert(message: "You have no access to Setup")
                }
                
            }
        }
    }
    
    func didScrollTableView()
    {
        // No Need to Override
    }
    
    //MARK:- Open Bottom Tray
    @IBAction func swipeUp(sender:UISwipeGestureRecognizer)
    {
        let bottomTrayVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "BottomTrayViewController") as! BottomTrayViewController
        bottomTrayVC.delegate_QRCRProtocol = self
        bottomTrayVC.delegate_InternalProtocol = self
        let navVC = UINavigationController.init(rootViewController: bottomTrayVC)
        self.present(navVC, animated: true, completion: nil)
        
    }
    
    //MARK:- QRCODERead Protocol
    func didUpdate(qrcodeStr:String)
    {
        NetworkManager.sharedManager.getRmaDetails(rma: qrcodeStr, completion: { (returnStruct:Return?) in
            
            if let _ = returnStruct
            {
                let empID = DrConstants.kAppDelegate.loginUser.id!
                let prop = ["ticket_id": returnStruct?.id!, "emp_id": empID, "value":"Yes"] as! [String: String]
                
                NetworkManager.sharedManager.itemReceiveUpdate(properties: prop, completion: {
                    let detailsVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                    detailsVC.dataStruct = returnStruct
                    self.navigationController?.pushViewController(detailsVC, animated: true)
                })
            }
        })
    }

    //MARK: Internal Protocols Methods
    func didTappedInternalProtocols()
    {
        self.didSelectMenuButton(indexPath: IndexPath.init(row: 2, section: 1))
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}

