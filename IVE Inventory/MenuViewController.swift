//
//  ViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 20/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController, MenuSelectionProtocol {

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
        
        //FIXME:- Change Title Name Later
        //Later Edit
        //self.title = "Home"
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        //self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        //Cancel Button Add Left Side
        /* let cancelBtn = UIBarButtonItem.init(title: "CANCEL", style: .plain, target: self, action: #selector(cancelBtnPressed))
        cancelBtn.setTitleTextAttributes( [NSFontAttributeName: UIFont.init(name:  FontConstant.SFUI_TEXT_MEDIUM, size: 12.0)!], for: .normal)
        self.navigationItem.leftBarButtonItem = cancelBtn
        */
        
        //Done Button Add Left Side
        /*let doneBtn = UIBarButtonItem.init(title: "DONE", style: .plain, target: self, action: #selector(doneBtnPressed))
        doneBtn.setTitleTextAttributes( [NSFontAttributeName: UIFont.init(name: FontConstant.SFUI_TEXT_MEDIUM, size: 12.0)!], for: .normal)
        self.navigationItem.rightBarButtonItem = doneBtn
         */
        
        
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
                    //Do Processing
                }
                else
                {
                    self.showAlert(message: "You have no access of Vendors")
                }
            }
            else if indexPath.row == 1
            {
                if (DrConstants.kAppDelegate.loginUser.role == IVEUserRole.kAdmin ||   DrConstants.kAppDelegate.loginUser.access.contains(IVEAccess.kReturn))
                {
                    let controller = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "ReturnViewController")
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                else
                {
                    self.showAlert(message: "You have no access of Returns")
                }
                
            }
            else if indexPath.row == 2
            {
               /* let userdetailsVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "UserDetailViewController")
                self.navigationController?.pushViewController(userdetailsVC, animated: true) */
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
    
    //MARK:- Open Bottom Tray
    @IBAction func swipeUp(sender:UISwipeGestureRecognizer)
    {
        let bottomTrayVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "BottomTrayViewController") as! BottomTrayViewController
        let navVC = UINavigationController.init(rootViewController: bottomTrayVC)
        self.present(navVC, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}

