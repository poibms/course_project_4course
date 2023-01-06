//
//  UITableView+Ex.swift
//  CoreData-Blog
//

//

import UIKit

extension UITableView
{
    func register(nibName: String,
                  cell: String)
    {
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: cell)
    }
}
