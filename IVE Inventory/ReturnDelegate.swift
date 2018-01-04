//
//  ReturnDelegate.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 24/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit

protocol ReturnDelegateProtocol {
    func didSelectCell(indexPath:IndexPath)
}

class ReturnDelegate: NSObject {
    var searchBar : UISearchBar!
    var returnDelegate: ReturnDelegateProtocol!
}

extension ReturnDelegate: UITableViewDelegate, UIScrollViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let _ = returnDelegate
        {
            self.returnDelegate.didSelectCell(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        self.searchBar.resignFirstResponder()
    }
    
}
