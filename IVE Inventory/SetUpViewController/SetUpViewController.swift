//
//  SetUpViewController.swift
//  IVE Inventory
//
//  Created by Vivan Raghuvanshi on 05/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class SetUpViewController: UIViewController {
    
    //MARK: -------------OUTLETS/VARIABLES----------------
    
    @IBOutlet weak var table_View:UITableView!
    
    //MARK: -------------VIEW LIFE CYCLE----------------

    override func viewDidLoad() {
        super.viewDidLoad()
        table_View.tableFooterView = UIView.init(frame: .zero)
        self.configureNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: -------------PRIVATE METHODS----------------
    
    func configureNavigationBar() {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "backbutton_icon"), target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.title = "Setup"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
        
        let printerButton = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "User_Default"), target: self, action: #selector(printerButtonTapped))
        self.navigationItem.rightBarButtonItem = printerButton
    }
    
    //MARK:- NavigationBar Button Action
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func printerButtonTapped() {
        print("#function = \(#function)")
    }
}

//MARK: -------------UITableViewDataSource METHODS----------------

extension SetUpViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "CellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 20 * DrConstants.kSCALE_FACTOR)
        cell?.textLabel?.textColor = #colorLiteral(red: 0.01176470588, green: 0.03921568627, blue: 0.3568627451, alpha: 1)
        cell?.textLabel?.text = "Username"
        cell?.imageView?.image = #imageLiteral(resourceName: "User_Default")
        cell?.selectionStyle = .none
        
        let _switch = UISwitch()
        _switch.tintColor = #colorLiteral(red: 0.01176470588, green: 0.03921568627, blue: 0.3568627451, alpha: 1)
        _switch.onTintColor = #colorLiteral(red: 0.01176470588, green: 0.03921568627, blue: 0.3568627451, alpha: 1)
        _switch.thumbTintColor = #colorLiteral(red: 0.7072623372, green: 0.7366045117, blue: 0.7719837427, alpha: 1)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let accView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 150, height: cell?.frame.size.height ?? 100))
            accView.addSubview(_switch)
            cell?.accessoryView = accView
        } else {
            cell?.accessoryView = _switch
        }
        
        return cell ?? UITableViewCell()
    }
}

//MARK: -------------UITableViewDelegate METHODS----------------

extension SetUpViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 * DrConstants.kSCALE_FACTOR
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let separatorThickness = CGFloat(5 * DrConstants.kSCALE_FACTOR)
        let additionalSeparator = UIView.init(frame: CGRect.init(x: 0, y: (cell.frame.size.height - separatorThickness), width: cell.frame.size.width, height: separatorThickness))
        additionalSeparator.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        cell.addSubview(additionalSeparator)
    }
}

