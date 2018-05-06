//
//  drConstants.swift
//  Diro
//
//  Created by Raj Shekhar on 20/01/17.
//  Copyright © 2017 Diro. All rights reserved.
//

import UIKit

public struct DrConstants
{
    static let kUser_Default        = UserDefaults.standard
    static let kAppDelegate         = UIApplication.shared.delegate as! AppDelegate
    
    static let kSCALE_FACTOR        = CGFloat().scaleFactor()
    static let kStoryBoard          = UIStoryboard(name: "Main", bundle: nil)
    static let kBaseUrl             = "http://stackup.mobi/220electronics/api/"
    static let kBaseUrlImage        = "http://stackup.mobi/220electronics/"
    
    static let kInternalPlaceholder = "Please Enter Your Internal Notes(Optional)"
    static let kDevice:UIUserInterfaceIdiom  = UIDevice.current.userInterfaceIdiom
}

public struct IVE_URLConstant
{
    static let kRmaList = DrConstants.kBaseUrl+"ticket?"
    static let kRmaDetail = DrConstants.kBaseUrl+"ticket/detail?"
    static let kRmaUpdate = DrConstants.kBaseUrl+"ticket/update/"
    static let kLogin = DrConstants.kBaseUrl+"employee/login?"
    static let kRegisterUser =  DrConstants.kBaseUrl+"employee/register"
    static let kUsersList = DrConstants.kBaseUrl+"employee"
    static let kUsersUpdate = DrConstants.kBaseUrl+"employee/update/"
    static let kPhotoUpdate = DrConstants.kBaseUrl+"employee/photoupdate/"
    static let kUserProfile = DrConstants.kBaseUrl+"employee/profile/"
    static let kVendorsList = DrConstants.kBaseUrl+"ticket/vendors_list"
    static let kVendorsRmaList = DrConstants.kBaseUrl+"ticket/vendors_rma"
    static let kVendorsRmaUpdate = DrConstants.kBaseUrl+"ticket/change_vendorrma_status"
    
    static let kCustomerSideUpdate = DrConstants.kBaseUrl+"/ticket/customer_side_update"
    static let kInventorySideUpdate = DrConstants.kBaseUrl+"/ticket/inventory_side_update"
    static let kInternalNotes = DrConstants.kBaseUrl+"/ticket/view_rma_log"
    static let kItemReceiveUpdate = DrConstants.kBaseUrl+"ticket/item_receive_update"
    static let kInventoryReceipt = DrConstants.kBaseUrl+"/inventory"
    static let kPrice_ok = DrConstants.kBaseUrl+"inventory/price_ok"
    static let kReceived_qb = DrConstants.kBaseUrl+"inventory/received_qb"
    static let kInvoice_paid = DrConstants.kBaseUrl+"inventory/invoice_paid"
    static let kInventory_Logs = DrConstants.kBaseUrl+"inventory/inventory_log"
    static let kInventory_Submit = DrConstants.kBaseUrl+"inventory/submit"
    
    static let kPostInventory_Log = DrConstants.kBaseUrl+"inventory/internal_note"
    static let kPostRma_Log = DrConstants.kBaseUrl+"ticket/internal_note"
    
    static let kAddNewVendor = DrConstants.kBaseUrl+"ticket/add_new_vendor"
    static let kUpdateVendor = DrConstants.kBaseUrl+"ticket/update_vendor"
    static let kDeleteVendor = DrConstants.kBaseUrl+"ticket/delete_vendor"

    
}

public struct IVE_KeyConstant
{
    static let kName = "name"
    static let kPassword = "password"
    static let kId = "id"
    static let kUser_id = "user_id"
    static let kEmail = "email"
    static let kInitial = "initial"
    static let kPhoto = "photo"
    static let kData = "data"
    static let kIs_deleted = "is_deleted"
    static let kAccess = "access"

    static let kStatus = "status"
    static let kSuccess = "success"
    static let kError = "error"
}


public struct IVEUserRole
{
    static let kAdmin = "admin"
    static let kUser = "admin"
}


public struct IVEAccess
{
    static let kAdmin_Access = "admin_acess"
    static let kReturn = "return"
    static let kRma_Detail = "rma_retail"
    static let kRma_Print = "rma_print"
    static let kVendors = "vendors"
}


//==========================
//MARK:Device Types & Size

public struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

public struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
}

  var   AppColor                     : UIColor { return UIColor.init(red: 3.0/255.0, green: 115.0/255.0, blue: 218.0/255.0, alpha: 1) }
  var   NextArrowColor               : UIColor { return UIColor.init(red: 199.0/255.0, green: 199.0/255.0, blue: 204.0/255.0, alpha: 1) }
  let   HeaderColor                  = UIColor.init(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)
  let   SubHeaderColor               = UIColor.init(red: 214.0/255.0, green: 218.0/255.0, blue: 222.0/255.0, alpha: 1)
  var   CellbackGroundColor          :  UIColor{ return UIColor.init(red: 199.0/255.0, green: 199.0/255.0, blue: 204.0/255.0, alpha: 1.0) }
  var   lighTextColor                :  UIColor{ return UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.7) }
  var   tableseparator               :  UIColor{ return UIColor.init(red: 224.0/255.0, green: 224.0/255.0, blue:224.0/255.0, alpha: 0.1) }



public struct IVEFontConstant
{
    static let SFUI_TEXT_REGULAR                = "SFUIText-Regular"
    static let SFUI_TEXT_MEDIUM                 = "SFUIText-Medium"
    static let SFUI_TEXT_BOLD                   = "SFUIText-Bold"
    static let SFUI_SEMIBOLD                    = "SFUIText-Semibold"
    static let SFUI_LIGHT_FONT                  = "SFUIText-Light"
}



public struct ColorConstant
{
    static let blueFillColor = UIColor.hexStringToUIColor(hex: "#030a5b")
    static let saffroFillColor = UIColor.hexStringToUIColor(hex: "#EF6F0C")
    static let grayFillColor = UIColor.hexStringToUIColor(hex: "#D8DBE3")
    static let graySeperatorColor = UIColor.hexStringToUIColor(hex: "#f7f9fb")
    static let titleColor = UIColor.hexStringToUIColor(hex: "#9f9f9f")
    static let navBarColor = UIColor.hexStringToUIColor(hex: "#d8dbe3")
    
    static let leftRedColor = UIColor.init(red:195.0/255.0, green:24.0/255.0, blue:0.0/255.0, alpha:1.0)
    static let rightRedColor = UIColor.init(red:239.0/255.0, green:151.0/255.0, blue:0.0/255.0, alpha:1.0)
    
    static let btnTextColor = UIColor.init(red:218.0/255.0, green:218.0/255.0, blue:218.0/255.0, alpha:1.0)
    static let btnBgColor = UIColor.init(red:246.0/255.0, green:246.0/255.0, blue:246.0/255.0, alpha:1.0)
}



