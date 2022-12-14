//
//  ProfileViewModel.swift
//  CoreData-Blog
//

//

import Foundation

// MARK: - Initialize
final class ProfileViewModel
{
    weak var delegate: ProfileViewModelDelegate?
    private var service: IProfileService
    private var articles: [Article] = []
    
    init(service: IProfileService)
    {
        self.service = service
    }
}

// MARK: - ViewModel Protocol
extension ProfileViewModel: ProfileViewModelProtocol
{
    func loadFavoriteArticles(with category: String,
                             _ fetchOffset: Int)
    {
        service.getFavoriteArticles(with: category,
                                    fetchOffset) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success((let articles, let count)):
                self.articles = articles
                self.notify(.favoriteArticles(self.articles, count))
            case .failure(let error):
                self.notify(.showError(error))
            }
        }
    }
    
    func removeFavorites(with id: UUID,
                         on category: String)
    {
        service.removeOrAddFavorites(with: id) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success((let article, let isFavorite)):
                self.notify(.removeFavorite((article, isFavorite)))
            case .failure(let error):
                self.notify(.showError(error))
            }
        }
    }
    
    func removeStoredArticles()
    {
        service.removeStoredArticles()
    }
    
    func selectedArticle(article: Article)
    {
        let viewModel = DetailViewModel(service: HomeService(stack: app.stack))
        
        delegate?.navigate(to: .detail(viewModel, article))
    }
}

// MARK: - Helpers
extension ProfileViewModel
{
    private func notify(_ output: ProfileViewModelOutput)
    {
        delegate?.handleOutput(output)
    }
}
