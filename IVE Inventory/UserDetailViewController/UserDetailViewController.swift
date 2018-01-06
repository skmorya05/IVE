//
//  UserDetailViewController.swift
//  IVE Inventory
//
//  Created by Vivan Raghuvanshi on 05/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    //MARK: -------------OUTLETS/VARIABLES----------------
    
    @IBOutlet weak var cons_bwSL:NSLayoutConstraint!
    @IBOutlet weak var cons_leadSw:NSLayoutConstraint!
    @IBOutlet weak var cons_leadSw2:NSLayoutConstraint!

    
    //MARK: -------------VIEW LIFE CYCLE----------------

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        cons_leadSw.constant = 15 * DrConstants.kSCALE_FACTOR
        cons_leadSw2.constant = 12 * DrConstants.kSCALE_FACTOR
        cons_bwSL.constant = 12 * DrConstants.kSCALE_FACTOR

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -------------PRIVATE METHODS----------------
    
    func configureNavigationBar() {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem.itemWith(colorfulImage:#imageLiteral(resourceName: "backbutton_icon"), target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.title = "Username"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
    }
    
    //MARK:- NavigationBar Button Action
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
