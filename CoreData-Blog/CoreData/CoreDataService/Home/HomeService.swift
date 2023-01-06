//
//  CoreDataService.swift
//  CoreData-Blog
//

//

import UIKit
import CoreData

final class HomeService: BaseService
{
    override init(
        stack: CoreDataStack,
        storedArticles: [Article] = []
    ) {
        super.init(stack: stack, storedArticles: storedArticles)
    }
}

extension HomeService: IHomeService
{
    func getArticles(fetchOffet: Int,
                     completion: @escaping (Result<([Article], Int)>) -> Void)
    {
        let dateSort: NSSortDescriptor = NSSortDescriptor(key: #keyPath(Article.createdDate), ascending: true)
        let reversedDate = dateSort.reversedSortDescriptor as! NSSortDescriptor
        
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        fetchRequest.sortDescriptors = [reversedDate]
        fetchRequest.fetchLimit = 5
        fetchRequest.fetchOffset = fetchOffet
        
        let count = self.currentAllArticlesCount()
        
        self.makePagination(currentArticlesCount: count,
                            fetchRequest: fetchRequest) { [weak self] (result) in
            guard let _ = self else { return }
            
            switch result {
            case .success(let articles):
                completion(.success((articles, count)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addArticle(with title: String,
                    _ content:  String,
                    _ image: UIImage,
                    _ category: String) throws
    {
        let article = Article(context: stack.managedContext)
        let author  = Author(context: stack.managedContext)
        
        author.userName     = UserDefaults.standard.string(forKey: "login") ?? "unowned" // todo.
        
        article.title       = title
        article.content     = content
        article.category    = category
        article.isFavorite  = false
        article.id          = UUID()
        article.createdDate = Date()
        article.articleImage = image
        article.author      = author
        
        stack.saveContext()
    }

    func removeArticleFromMain(by title: String) {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)

        do {
            guard let article = try stack.managedContext.fetch(request).first else { return }
            stack.managedContext.delete(article)
            stack.saveContext()
            print("DELETED")
        } catch (let e) {
            print(e)
        }
    }

    private func currentAllArticlesCount() -> Int
    {
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        let count = try! stack.managedContext.count(for: fetchRequest)
        
        return count
    }
}
