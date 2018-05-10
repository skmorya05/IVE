//
//  VendorsRmaStatusVC.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 24/04/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class VendorsRmaStatusVC: UIViewController, UITableViewDataSource, UITableViewDelegate, StatusUpdateProtocol
{

    @IBOutlet weak var view_gradientBorder:UIView!
    @IBOutlet weak var vendor_tableView:UITableView!
    var vendor: IVEVendor!
    var rmaStatusList: [Return]!
    var isStatusUpdate = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print("vendor = \(vendor)")
        configureNavigationBar()
        self.edgesForExtendedLayout = []
        
        self.vendor_tableView.register(UINib.init(nibName: "RmaStatusCell", bundle: nil), forCellReuseIdentifier: "RmaStatusCell")
        
        self.vendor_tableView.estimatedRowHeight = 121.0
        self.vendor_tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshTable()
    }

    func refreshTable()
    {
        self.rmaStatusList = [Return]()
        JustHUD.shared.showInView(view: self.view)
        
        NetworkManager.sharedManager.getRmaStatusList(vendorid: self.vendor.id) { (rmaStatusList) in
            
            for rma in rmaStatusList!
            {
                let model = Return.init(dict: rma)
                self.rmaStatusList.append(model)
            }
            
            self.vendor_tableView.dataSource = self
            self.vendor_tableView.delegate = self
            self.vendor_tableView.reloadData()
            JustHUD.shared.hide()
        }
    }
    
    func configureNavigationBar()
    {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "backbutton_icon"), target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.title = "RMA Status"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
        
        self.view_gradientBorder.addHorizontalGradientColor(leftColor: ColorConstant.leftRedColor, and: ColorConstant.rightRedColor)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.rmaStatusList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 121.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "RmaStatusCell", for: indexPath) as! RmaStatusCell
        cell.delegate = self
        let model = self.rmaStatusList[indexPath.row]
        cell.lblName.text = model.name
        cell.lblRma.text = model.rma
        cell.lblBrand.text = model.brand
        cell.lblCreatedate.text = model.createdate
        cell.lblPhone.text = model.phone
        cell.lblModel.text = model.model
        cell.lblStatus.text = model.status
        
        if model.status.lowercased() == "shipped"
        {
            cell.btnStatus.isSelected = false
        }
        else if model.status.lowercased() == "open"
        {
            cell.btnStatus.isSelected = true
        }
        
        return cell
    }
    
    func didUpdateStatus(cell:RmaStatusCell)
    {
        if let indexPath = self.vendor_tableView.indexPath(for: cell)
        {
            var model = self.rmaStatusList[indexPath.row]
            
            if cell.btnStatus.isSelected
            {
                model.status = "shipped"
            }
            else
            {
                model.status = "open"
            }
            
            let property: [String: String] = ["ticket_id": model.id, "status": model.status]
            JustHUD.shared.showInView(view: self.view)
            NetworkManager.sharedManager.updateRmaStatus(prop: property, completion: { (isUpdated) in
                if let _ = isUpdated
                {
                    if isUpdated!
                    {
                        JustHUD.shared.hide()
                        self.refreshTable()
                    }
                }
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(true)
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
