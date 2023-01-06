//
//  ISearchService.swift
//  CoreData-Blog
//

//

import Foundation

protocol ISearchService
{
    func getArticles(with query: String,
                     selectedCategory: String,
                     fetchOffset: Int,
                     completion: @escaping (Result<([Article], Int)>) -> Void)
    func getRecommendArticles(with category: String,
                     fetchOffset: Int,
                     completion: @escaping (Result<([Article], Int)>) -> Void)
    func removeOrAddFavorites(with id: UUID,
                      completion: @escaping (Result<(Article, Bool)>) -> Void)
    func removeStoredArticles()
}
