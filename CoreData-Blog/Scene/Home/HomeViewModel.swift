//
//  HomeViewModel.swift
//  CoreData-Blog
//

//

import Foundation
import CoreData

// MARK: - Initialize
final class HomeViewModel: HomeViewModelProtocol
{
    weak var delegate: HomeViewModelDelegate?
    private let service: IHomeService
    private var articles: [Article] = []
    
    init(service: IHomeService)
    {
        self.service = service
    }
}

// MARK: - ViewModel's Protocol
extension HomeViewModel
{
    func removeArticle(with title: String)
    {
        service.removeArticleFromMain(by: title)
    }

    func loadPaginatedArticles(with fetchOffset: Int)
    {
        service.getArticles(fetchOffet: fetchOffset) { [weak self] result in
            guard let self = self else { return }
           
            switch result {
            case .success((let articles, let count)):
                self.articles = articles
                self.notify(.paginatedArticles((self.articles, count)))
            case .failure(let error):
                self.notify(.showError(error))
            }
        }
    }
    
    func addFavorites(with id: UUID)
    {
        service.removeOrAddFavorites(with: id) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success((let article, let isFavorite)):
                self.notify(.isFavorited((article, isFavorite)))
            case .failure(let error):
                self.notify(.showError(error))
            }
        }
    }
    
    func removeStoredArticles()
    {
        service.removeStoredArticles()
    }
    
    func selectAddButton()
    {
        let addViewModel = AddArticleViewModel(service: service)
        
        delegate?.navigate(to: .add(addViewModel))
    }
    
    func selectedArticle(article: Article)
    {
        let detailViewModel = DetailViewModel(service: service)
        
        delegate?.navigate(to: .detail(article, detailViewModel))
    }
}

// MARK: - Helpers
extension HomeViewModel
{
    private func notify(_ output: HomeViewModelOutput)
    {
        delegate?.handleOutput(output)
    }
}
