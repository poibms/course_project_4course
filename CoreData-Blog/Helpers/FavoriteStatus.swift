//
//  FavoriteStatus.swift
//  CoreData-Blog
//

//

import Foundation

enum FavoriteStatus
{
    case success
    case info
    
    static func selectStatus(with isFavorite: Bool) -> FavoriteStatus
    {
        switch isFavorite {
        case true: return .success
        case false: return .info
        }
    }
}
