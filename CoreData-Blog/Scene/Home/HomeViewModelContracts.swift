//
//  HomeViewModelContracts.swift
//  CoreData-Blog
//

//

import Foundation

protocol HomeViewModelProtocol
{
    var delegate: HomeViewModelDelegate? { get set }
    
    func loadPaginatedArticles(with fetchOffset: Int)
    func selectedArticle(article: Article)
    func addFavorites(with id: UUID)
    func removeStoredArticles()
    func selectAddButton()
    func removeArticle(with title: String)
}

protocol HomeViewModelDelegate: AnyObject
{
    func handleOutput(_ output: HomeViewModelOutput)
    func navigate(to route: HomeViewModelRouter)
}

enum HomeViewModelRouter
{
    case add(AddArticleViewModelProtocol)
    case detail(Article, DetailViewModelProtocol)
}

enum HomeViewModelOutput
{
    case paginatedArticles(([Article], Int))
    case showError(Error)
    case isFavorited((Article, Bool))
}
