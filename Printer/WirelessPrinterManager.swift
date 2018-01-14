//
//  WirelessPrinterManager.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 07/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit
let kPaperSizeA4 = CGSize.init(width: 595.2, height: 841.8)
let kPaperSizeLetter = CGSize.init(width: 612, height: 792)

class WirelessPrinterManager: NSObject, NDHTMLtoPDFDelegate
{
    static let shared = WirelessPrinterManager()
    
    func openPrinterPreview(printDocArray : [Return], viewController:UIViewController)
    {
        var htmlText = String()
        htmlText.append("<html><head><title>First Table</title><style>table , td, table , tr, th{border:1px solid #333333;padding:2px;}</style></head><body><h1 align='center'>RMA List</h1></br><table ><tr><th>RMA No</th><th>Name</th><th>Brand</th><th>Serial</th><th>Model</th><th>Create Date</th><th>Reason</th><th>Close Date</th><th>Close By</th></tr>")
        
        for dictCell in printDocArray //Return
        {
            htmlText.append("<tr>")
            //add table column  value
            let propArr = [dictCell.rma, dictCell.name, dictCell.brand, dictCell.serial, dictCell.model, dictCell.createdate, dictCell.reason, dictCell.closedate, dictCell.closeby]

            for element in propArr
            {
                if let _ = element
                {
                    htmlText.append("<td align='center'>\(element!)</td>")
                }
                else
                {
                    htmlText.append("<td align='center'> </td>")
                }
            }
            htmlText.append("</tr>")
        }
        
        htmlText.append("</table>")
        htmlText.append("</body>")
        htmlText.append("</html>")
        
        let pc = UIPrintInteractionController.shared
        
        let printInfo = UIPrintInfo.printInfo()
        printInfo.outputType = .general
        printInfo.orientation = .portrait
        printInfo.jobName = "RMA Report"
        
        pc.printInfo = printInfo
        
        let formatter = UIMarkupTextPrintFormatter(markupText:htmlText)
        formatter.perPageContentInsets = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
        pc.printFormatter = formatter
        
        pc.present(animated: true, completionHandler: nil)
        
    }
    
}
