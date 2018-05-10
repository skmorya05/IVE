//
//  DataSource_DetailsViC.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 03/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation

class DataSource_DetailsVC: NSObject
{
    weak var vc: DetailsViewController!
    var rmaStruct: Return!
}

extension DataSource_DetailsVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RmaDetailCell", for: indexPath) as! RmaDetailCell
            cell.selectionStyle = .none
            if let _ = self.rmaStruct
            {
                cell.lbl_Rma.text = self.rmaStruct.rma
                cell.lbl_RmaType.text = self.rmaStruct.rma_type
                cell.lbl_Name.text = self.rmaStruct.name
                cell.lbl_Company.text = self.rmaStruct.company_name
                cell.lbl_Address.text = self.rmaStruct.address
                cell.lbl_Brand.text = self.rmaStruct.brand
                cell.lbl_Model.text = self.rmaStruct.model
                cell.lbl_Serial.text = self.rmaStruct.serial
                cell.lbl_Order.text = self.rmaStruct.orders
                cell.lbl_SalesReceipt.text = self.rmaStruct.sales_receipt
                cell.lbl_PurchaseDate.text = self.rmaStruct.purchase_date
                cell.lbl_ReasonForReturn.text = self.rmaStruct.reason
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RmaContainerCell", for: indexPath) as! RmaContainerCell
        cell.selectionStyle = .none
        if let _ = self.vc
        {
            cell.delegate_InternalProtocol = self.vc
            cell.vcObject = self.vc
            cell.configureView()
        }
        
        if let _ = self.rmaStruct
        {
            cell.rmaStruct = self.rmaStruct
            self.perform(#selector(DataSource_DetailsVC.updateCell(_:)), with:cell , afterDelay: 0.1)
        }
        
        return cell
    }
    
    @objc func updateCell(_ cell:RmaContainerCell)
    {
        cell.updateView()
    }
}
