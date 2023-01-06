//
//  UIButton+Ex.swift
//  CoreData-Blog
//

//

import UIKit

extension UIButton
{
    func setBookMark(bookMark: SelectBookMark)
    {
        self.setBackgroundImage(
            UIImage(systemName: bookMark.selectedBookMark),
            for: .normal)
    }
}
