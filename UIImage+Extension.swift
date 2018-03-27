//
//  UIImage+Extension.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 20/03/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation

public enum ImageFormat {
    case PNG
    case JPEG(CGFloat)
}

extension UIImage {
    
    public func base64(format: ImageFormat) -> String? {
        var imageData: Data?
        switch format {
        case .PNG: imageData = UIImagePNGRepresentation(self)
        case .JPEG(let compression): imageData = UIImageJPEGRepresentation(self, compression)
        }
        return imageData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)

    }
}
