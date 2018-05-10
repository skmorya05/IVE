//
//  VendorsViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 23/04/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class VendorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var view_gradientBorder:UIView!
    @IBOutlet weak var vendor_tableView:UITableView!
    
    var vendorsList = [IVEVendor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       configureNavigationBar()
       self.vendor_tableView.register(UINib.init(nibName: "VendorsCell", bundle: nil), forCellReuseIdentifier: "VendorsCell")
       self.vendor_tableView.estimatedRowHeight = 110
       self.vendor_tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        VendorManager.sharedManager.getVendorsList { (list) in
            
            self.vendorsList = list
            self.vendor_tableView.dataSource = self
            self.vendor_tableView.delegate = self
            self.vendor_tableView.reloadData()
        }
    }

    func configureNavigationBar()
    {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "backbutton_icon"), target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.title = "Manage Vendors"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
        
        self.view_gradientBorder.addHorizontalGradientColor(leftColor: ColorConstant.leftRedColor, and: ColorConstant.rightRedColor)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
    //MARK:  Btn Tapped NavBar
    @objc func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.vendorsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (DrConstants.kDevice == .pad)
        {
            return 110.0*DrConstants.kSCALE_FACTOR
        }
        
        return  UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VendorsCell", for: indexPath) as! VendorsCell
        let vendor = self.vendorsList[indexPath.row]
        cell.lblName.text =  "   \(vendor.name)"
        cell.lblEmail.text = "   \(vendor.email)"
        cell.lblPhone.text = "   \(vendor.phone)"
        
        if Int(vendor.openStatus) != 0 || Int(vendor.shipStatus) != 0
        {
            cell.accessoryType = .disclosureIndicator
        }

        cell.lblOpen.text = "  Open:  \(vendor.openStatus)"
        cell.lblShipped.text = "  Shipped: \(vendor.shipStatus)  "
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let vendor = self.vendorsList[indexPath.row]
        
        if Int(vendor.openStatus) != 0 || Int(vendor.shipStatus) != 0
        {
            let controller = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "VendorsRmaStatusVC") as! VendorsRmaStatusVC
            controller.vendor = self.vendorsList[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
