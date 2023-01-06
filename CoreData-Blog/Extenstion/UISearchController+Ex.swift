//
//  UISearchController+Ex.swift
//  CoreData-Blog
//

//

import UIKit

extension UISearchController
{
    var isSearchBarEmpty: Bool {
        return self.searchBar.text?.isEmpty ?? true
    }
    
    var isSearching: Bool {
        return self.isActive && !isSearchBarEmpty
    }
}
