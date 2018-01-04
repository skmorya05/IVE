//
//  ReturnScrollDelegate.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 24/12/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import Foundation
import UIKit

protocol ReturnSearchProtocol: class
{
    func didFilterWithSearchText(searchText:String)
    func didPressSearchBarCancelButton()
}

class ReturnSearchDelegate: NSObject
{
    var returnDelegate: ReturnSearchProtocol!
}

extension ReturnSearchDelegate: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if let _ = returnDelegate
        {
            self.returnDelegate.didFilterWithSearchText(searchText: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        if let _ = returnDelegate
        {
            self.returnDelegate.didPressSearchBarCancelButton()
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool
    {
        searchBar.showsCancelButton = true
        return true
    }
}
