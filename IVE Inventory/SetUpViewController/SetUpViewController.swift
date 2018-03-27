//
//  SetUpViewController.swift
//  IVE Inventory
//
//  Created by Vivan Raghuvanshi on 05/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit



class SetUpViewController: UIViewController, SetUpTapProtocol, SwitchStatusChange
{
    
    //MARK: -------------OUTLETS/VARIABLES----------------
    @IBOutlet weak var table_View:UITableView!
    @IBOutlet weak var view_gradientBorder:UIView!
    
    
    var dataSource = SetUpDataSource()
    var delegate = SetUpDelegate()
    

    //MARK: -------------VIEW LIFE CYCLE----------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        table_View.tableFooterView = UIView.init(frame: .zero)
        self.configureNavigationBar()
        self.view_gradientBorder.addHorizontalGradientColor(leftColor: ColorConstant.leftRedColor, and: ColorConstant.rightRedColor)
        
        table_View.register(UINib.init(nibName: "SetUpCell", bundle: nil), forCellReuseIdentifier: "SetUpCell")
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        loadData()
    }
    
    func loadData()
    {
        NetworkManager.sharedManager.getUsersList { (_ users:[IVE_User]?) in
            
            if let usersList = users
            {
                self.dataSource.usersList = usersList
                self.dataSource.viewControllerObj = self
                self.delegate.users = usersList
                self.delegate.delegate = self
                
                self.table_View.dataSource = self.dataSource
                self.table_View.delegate = self.delegate
                self.table_View.reloadData()
            }
        }
    }
    
    
    //MARK: -------------PRIVATE METHODS----------------
    func configureNavigationBar()
    {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "backbutton_icon"), target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.title = "Setup"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
        
        let userButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "User_Default") , target: self, action: #selector(userButtonTapped))
        self.navigationItem.rightBarButtonItem = userButton
    }
    
    //MARK:- NavigationBar Button Action
    @objc func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func userButtonTapped()
    {
        print("#function = \(#function)")
        let registerVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        registerVC.pageDisplayMode = .profileUpdate
        self.navigationController?.pushViewController(registerVC, animated: true)
        
    }
    
    //MARK:- SetUpTapProtocol -
    func didSelectSetUpCell(indexPath: IndexPath, user:IVE_User)
    {
        print("\n indexPath = \(indexPath)")
        
        let userDetailVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        userDetailVC.ive_user = user
        self.navigationController?.pushViewController(userDetailVC, animated: true)
    }
    
    //MARK:- SwitchStatusChange -
    func didChangeStatus(cell:SetUpCell, user:IVE_User)
    {
        NetworkManager.sharedManager.updateUserDict(user: user, status: cell.switch_role.isOn, completion: { (_ result: Bool) in
            
            self.loadData()
        })
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

