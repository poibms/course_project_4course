//
//  ICoreDataService.swift
//  CoreData-Blog
//

//

import UIKit
import CoreData

protocol IHomeService
{
    func getArticles(fetchOffet: Int,
                     completion: @escaping (Result<([Article], Int)>) -> Void)
    func removeOrAddFavorites(with id: UUID,
                              completion: @escaping (Result<(Article, Bool)>) -> Void)
    func addArticle(with title: String,
                    _ content: String,
                    _ image: UIImage,
                    _ category: String) throws
    func removeStoredArticles()
    func removeArticleFromMain(by title: String)
}
