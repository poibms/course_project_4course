//
//  IProfileService.swift
//  CoreData-Blog
//

//

import CoreData


protocol IProfileService
{
    func getFavoriteArticles(with category: String,
                             _ fetchOffset: Int,
                             completion: @escaping (Result<([Article], Int)>) -> Void)
    func removeOrAddFavorites(with id: UUID,
                              completion: @escaping (Result<(Article, Bool)>) -> Void)
    func removeStoredArticles()
}
