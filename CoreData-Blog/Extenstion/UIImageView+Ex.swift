//
//  UIImage+Ex.swift
//  CoreData-Blog
//

//

import UIKit

extension UIImageView
{
    func makeRoundedCircle()
    {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    func makeRounded()
    {
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
}
