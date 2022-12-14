//
//  ProfileService.swift
//  CoreData-Blog
//

//

import CoreData

final class ProfileService: BaseService
{
    override init(
        stack: CoreDataStack,
        storedArticles: [Article] = []
    ) {
        super.init(stack: stack, storedArticles: storedArticles)
    }
}

extension ProfileService: IProfileService
{    
    func getFavoriteArticles(with category: String,
                             _ fetchOffset: Int,
                             completion: @escaping (Result<([Article], Int)>) -> Void)
    {
        let categoryPredicate: NSPredicate = NSPredicate(format: "category = %@", category)
        let favoritePredicate = NSPredicate(format: "isFavorite == YES")
        
        let dateSort = NSSortDescriptor(key: #keyPath(Article.createdDate), ascending: true)
        let reversedSort = dateSort.reversedSortDescriptor as! NSSortDescriptor
        
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,
                                                                                    favoritePredicate])
        fetchRequest.sortDescriptors = [reversedSort]
        fetchRequest.fetchLimit = 5
        fetchRequest.fetchOffset = fetchOffset
        
        let count = self.currentFavoriteArticlesCount(category: categoryPredicate,
                                                              favirote: favoritePredicate)
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
    
    private func currentFavoriteArticlesCount(category: NSPredicate,
                                              favirote: NSPredicate) -> Int
    {
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [category,
                                                                                    favirote])
        let count = try! stack.managedContext.count(for: fetchRequest)
        return count
    }
}
