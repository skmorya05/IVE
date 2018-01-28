//
//  SetUpDelegate.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 14/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import Foundation
import UIKit

protocol SetUpTapProtocol: class
{
    func didSelectSetUpCell(indexPath:IndexPath, user:IVE_User)
}


class SetUpDelegate: NSObject
{
    weak var delegate: SetUpTapProtocol!
    var users: [IVE_User]!
}

extension SetUpDelegate: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80 * DrConstants.kSCALE_FACTOR
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let separatorThickness = CGFloat(5 * DrConstants.kSCALE_FACTOR)
        let additionalSeparator = UIView.init(frame: CGRect.init(x: 0, y: (cell.frame.size.height - separatorThickness), width: cell.frame.size.width, height: separatorThickness))
        additionalSeparator.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        cell.addSubview(additionalSeparator)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let _ = self.delegate
        {
            let user = self.users[indexPath.row]
            self.delegate.didSelectSetUpCell(indexPath: indexPath, user:user)
        }
    }
}
