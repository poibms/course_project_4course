//
//  SelectSegmentControl.swift
//  CoreData-Blog
//

//

import Foundation

enum SelectCategory
{
    case nature
    case food
    case city
    case friends
}

extension SelectCategory: CaseIterable { }

extension SelectCategory: RawRepresentable
{
    typealias RawValue = String
    
    init?(rawValue: RawValue)
    {
        switch rawValue {
        case "Nature": self = .nature
        case "Food": self = .food
        case "City": self = .city
        case "Friends": self = .friends
        default : return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .nature: return "Nature"
        case .food: return "Food"
        case .city: return "City"
        case .friends: return "Friends"
        }
    }
}
