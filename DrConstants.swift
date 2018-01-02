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
    static let kPbDbName            = "dixie"
    static let kMediaDbName         = "mediadb"
    static let kGhostDBName         = "ghost_db"
    static let kImgDbName           = "img_db"
    static let kDuplicate           = "duplicate"
    static let kDx                  = "dx"
    static let kType                = "type"
    static let knumber              = "number"
    static let kkey                 = "key"
    static let kdiscard             = "discard"
    static let kOwner               = "owner"
    static let kBgColor             = "backgroundcolor"
    static let kEpTime              = "eptime"
    static let kCrTime              = "crtime"
    static let kImage               = "image"
    static let kImageList           = "imagelist"
    static let kCx                  = "cx"
    static let kCxId                = "cxid"
    static let kcxID                = "cxID"
    static let ksmsAllPressEpTime   = "smsAllPressEpTime"
    static let kDxp                 = "dxp"
    static let kPhone               = "phone"
    static let kEmail               = "email"
    static let kWebsite             = "website"
    static let kSocial              = "social"
    static let kAddress             = "address"
    static let kEvents              = "events"
    static let kDisplayName         = "displayname"
    static let k_Id                 = "_id"
    static let kFirstName           = "firstname"
    static let kMiddleName          = "middlename"
    static let kLastName            = "lastname"
    static let kPrefix              = "prefix"
    static let kSuffix              = "suffix"
    static let kOrgName             = "org_name"
    static let kOrgDept             = "org_dept"
    static let kOrgTitle            = "org_title"
    static let kOrgEpTime           = "org_eptime"
    static let kCurrent             = "current"
    static let kOrg                 = "org"
    static let kDxName              = "dxname"
    static let kDxType              = "dxtype"
    static let kInvited             = "invited"
    static let kAx                  = "ax"
    static let kNickName            = "nickname"
    static let kMxPx                = "mx_ps"
    static let kPrivate             = "Private"
    static let kGroup               = "Group"
    static let kOfficial            = "Official"
    static let kCxp                 = "cxp"
    static let kRoles               = "roles"
    static let kTrue                = "1"
    static let kFalse               = "0"
    static let kNote                = "notes"
    static let kArchiveDx           = "archivedx"
    static let kAuthMx              = "authmx"
    static let kCxOne               = "cxone"
    static let kIsNew               = "isnew"
    static let kSearchString        = "searchstr"
    static let kPriority            = "priority"
    static let kShareDx             = "sharedx"
    static let kLabel               = "label"
    static let kMobile              = "mobile"
    static let kProcess             = "process"
    static let kCximage             = "cximage"
    
    static let kSFUITextRegular     = "SFUIText-Regular"
    static let kSFUITextMedium      = "SFUIText-Medium"
    static let kSFUITextSemibold    = "SFUIText-Semibold"
    static let kSFUITextBold        = "SFUIText-Bold"

    static let kActive              = "active"
    static let kInactive            = "inactive"
    static let kDefault             = "default"
    static let kByteSize            = "bytesize"

    static let kSFUITextBoldFont    = "SFUIText-Bold"
    
    static let kSCALE_FACTOR        = CGFloat().scaleFactor()

    static let kLinkedCx            = "linkedcx"
    static let kMx                  = "mx"
    static let kLastSeven           = "lastseven"
    static let kLinked_Cxp          = "linked_cxp"
    static let kCoachLog            = "coachlog"
    static let kAdminDx             = "admindx"
    static let kMxID                = "mxid"
    static let kMxstart             = "mxstart"
    static let kMxend               = "mxend"
    static let kDirono              = "dirono"
    static let kOrgDisplayName      = "orgdisplay"
    static let kChannels            = "channels"
    static let kMxch                = "mxch"
    static let kNativeSync          = "nativeSync"
    static let kPriorityUpdateDict  = "PriorityUpdateDict"
    static let kDontLink            = "dontlink"

    static let kManualCx            = "manual_cx"

    static let kCustom              = "custom"
    static let kColor               = "color"
    static let kId                  = "id"
    static let kName                = "name"
    static let kValues              = "values"
    static let kDataId              = "dataid"
    static let kValue               = "value"
    static let kLastDigits          = 9

}


//==========================
//MARK:Device Types & Size

struct ScreenSize{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType{
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



  let  DIRO_NEW_FONT_DFI0            =  "dfi0"
  let  DIRO_NEW_FONT_DFI1            =  "dfi1"


// Hotline
let HOTLINE_APP_ID                   = "8e181069-bc81-4b6d-ae92-00a790d4c907"
let HOTLINE_APP_KEY                  =  "941f99d2-d1d7-4ab2-8ee9-2342b78d8c0a"




let SFUI_TEXT_REGULAR                = "SFUIText-Regular" //			@"Helvetica Neue"
let SFUI_TEXT_MEDIUM                 = "SFUIText-Medium"//			@"HelveticaNeue-Medium"
let SFUI_TEXT_BOLD                   = "SFUIText-Bold"
let SFUI_SEMIBOLD                    = "SFUIText-Semibold"
let SFUI_LIGHT_FONT                 = "SFUIText-Light"


//MARK: DIROCARD Constants

let mxID = UserDefaults.standard.object(forKey: "mxID") as! String


let foundDocID = "\(mxID)-foundedValueDoc"

let SOCIAL = "social"
let IMAGE = "image"
let IMAGELIST = "imagelist"
let VERIFIED_COUNT = "verifiedcount"
let PHONE = "phone"
let WORK = "work"
let EMAIL = "email"
let HOME = "home"
let ORG = "org"

let ADDRESS = "address"
let STREET = "Street"
let CITY = "City"
let STATE = "State"
let ZIP = "ZIP"
let COUNTRY_CODE = "CountryCode"

let EVENTS = "events"
let WEBSITE = "website"
let NOTES = "notes"

//MARK:CARD FEATURE CONSTANT
let FEATURES = "features"
let STATUS = "status"
let EVERYTHING = "a"
let BUSINESS = "b"
let PERSONAL = "p"
let MINIMAL = "m"

let callIcon = "k"
let emailIcon = "O"
let webSiteIcon = "P"
let orgIcon = "0"
let addressHomeIcon="2"

//MARK:CARD TYPE CONSTANTS
let EVERYTHING_CARD = "EVERYTHING"
let WORK_CARD = "WORK"
let PERSONAL_CARD = "PERSONAL"
let MINIMAL_CARD = "MINIMAL"


//FOUND SCREEN CONTANTS
let DISCARD = "discard"
let DISCARDED_IN_DIRO = "Discarded in Diro"
let DISCARD_COLOR = UIColor.init(red: 141.0/255.0, green: 156.0/255.0, blue: 168.0/255.0, alpha: 1.0)


let WHATSAPP_COLOR = UIColor.init(red:62.0/255.0, green:190.0/255.0, blue:38.0/255.0, alpha:1.0)
let FACEBOOK_COLOR = UIColor.init(red:33.0/255.0, green:91.0/255.0, blue:154.0/255.0, alpha:1.0)
let TWITTER_COLOR = UIColor.init(red:0.0/255.0, green:173.0/255.0, blue:242.0/255.0, alpha:1.0)
let LINKEDIN_COLOR = UIColor.init(red:0.0/255.0, green:116.0/255.0, blue:161.0/255.0, alpha:1.0)
let GOOGLE_PLUS_COLOR = UIColor.init(red:218.0/255.0, green:72.0/255.0, blue:53.0/255.0, alpha:1.0)


let FACEBOOK_ICON = "S"
let TWITTER_ICON = "R"
let WHATSAPP_ICON = "K"
let LINKEDIN_ICON = "U"
let GOOGLEPLUS_ICON = "T"

let EMPTY_MY_CONTACT_HISTORY    =  " This is a private phonebook,\n never shared "



//MARK: Coach Marks Constants
let CoachID = "coachid"
let CoachLog = "coachlog"
let DateValue = "datevalue"
let Count = "count"
let Details = "details"
let AreaID = "areaid"
let OverallCount = "overallcount"
let LogArray = "logarray"

let EpTime = "eptime"
let XxValue = "value"
let TextShown = "textshown"



