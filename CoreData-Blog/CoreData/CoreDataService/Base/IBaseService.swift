//
//  IBaseService.swift
//  CoreData-Blog
//

//

import CoreData

protocol IBaseService
{
    func removeStoredArticles()
    func removeOrAddFavorites(with id: UUID,
                      completion: @escaping (Result<(Article, Bool)>) -> Void)
    func makePagination(currentArticlesCount: Int,
                    fetchRequest: NSFetchRequest<Article>,
                    completion: @escaping (Result<[Article]>) -> Void)
}
