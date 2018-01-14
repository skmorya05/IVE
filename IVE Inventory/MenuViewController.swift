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
    let menuArray = ["Vendors", "Returns", "Inventory Receipt", "Setup"]
    
    //properties
    let dataSource = MenuViewDataSource()
    let delegate = MenuViewDelegate()
    
    func goTosetUpVC()
    { // SetUpViewController UserDetailViewController
        let setUpVC = UserDetailViewController.init(nibName: "UserDetailViewController", bundle: nil)
        self.navigationController?.pushViewController(setUpVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // goTosetUpVC()
        //return
        
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
                
            }
            else if indexPath.row == 1
            {
                let controller = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "ReturnViewController")
                self.navigationController?.pushViewController(controller, animated: true)
            }
            else if indexPath.row == 2
            {
                let userdetailsVC = UserDetailViewController.init(nibName: "UserDetailViewController", bundle: nil)
                self.navigationController?.pushViewController(userdetailsVC, animated: true)
            }
            else if indexPath.row == 3
            {
                let setUpVC = SetUpViewController.init(nibName: "SetUpViewController", bundle: nil)
                self.navigationController?.pushViewController(setUpVC, animated: true)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}

