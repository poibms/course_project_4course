//
//  BookMark.swift
//  CoreData-Blog
//

//

import Foundation

enum SelectBookMark
{
    case bookMark
    case bookMarkFill
    
    var selectedBookMark: String
    {
        switch self {
        case .bookMark:
            return "bookmark"
        case .bookMarkFill:
            return "bookmark.fill"
        }
    }
}
