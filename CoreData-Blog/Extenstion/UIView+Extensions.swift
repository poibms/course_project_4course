//
//  UIView+Extensions.swift
//  CoreData-Blog
//

//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}

