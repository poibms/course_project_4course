//
//  DataFormatter+Ex.swift
//  CoreData-Blog
//

//

import Foundation

extension Date
{
    func getFormattedDate(format: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.string(from: self)
    }
}
