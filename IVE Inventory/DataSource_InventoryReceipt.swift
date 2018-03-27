//
//  DataSource_InventoryReceipt.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 08/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class DataSource_InventoryReceipt: NSObject
{
    var receipts:[IVEReceipt]!
}

extension DataSource_InventoryReceipt: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return receipts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryReceiptCell", for: indexPath) as!  InventoryReceiptCell
        let receipt = self.receipts[indexPath.row]
        
        cell.lbl_Ir.text = receipt.receipt_no
        cell.lbl_Name.text = receipt.name
        cell.lbl_CreateDate.text = receipt.date_created
        
        if receipt.images.count != 0
        {
            let imageDict = receipt.images.first!
            if var imageStr = imageDict["image_name"] as? String
            {
               imageStr = "\(DrConstants.kBaseUrlImage)\(imageStr)"
                cell.img_IRReceipt?.sd_setImage(with: URL(string:imageStr), placeholderImage: UIImage(named: "electronics"))
            }
        }

        //Buttons State
        if let price_ok = receipt.price_ok
        {
            cell.btn_PriceOk.isSelected = (price_ok ==  "Yes") ? true : false
        }
        cell.btn_PriceOk.addTarget(self, action: #selector(btnTapped_priceOk), for: .touchUpInside)
        
        
        if let received_qb = receipt.received_qb
        {
            cell.btn_ReceivedQB.isSelected = (received_qb ==  "Yes") ? true : false
        }
        cell.btn_ReceivedQB.addTarget(self, action: #selector(btnTapped_ReceivedQB), for: .touchUpInside)
        
        
        if let invoice_paid = receipt.invoice_paid
        {
            cell.btn_InvoicePaid.isSelected = (invoice_paid ==  "Yes") ? true : false
        }
        cell.btn_InvoicePaid.addTarget(self, action: #selector(btnTapped_InvoicePaid), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func btnTapped_priceOk(sender:UIButton)
    {
        print("\(#function)")
        sender.isSelected = !sender.isSelected
    }
    
    @objc func btnTapped_ReceivedQB(sender:UIButton)
    {
        print("\(#function)")
        sender.isSelected = !sender.isSelected
    }
    
    @objc func btnTapped_InvoicePaid(sender:UIButton)
    {
        print("\(#function)")
        sender.isSelected = !sender.isSelected
    }
}
