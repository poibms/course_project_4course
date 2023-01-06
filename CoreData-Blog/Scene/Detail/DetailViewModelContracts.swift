//
//  DetailViewModelContracts.swift
//  CoreData-Blog
//

//

import Foundation

protocol DetailViewModelProtocol
{
    var delegate: DetailViewModelDelegate? { get set }
    
    func addFavorites(with id: UUID)
}

protocol DetailViewModelDelegate: AnyObject
{
    func handleOutput(_ output: DetailViewModelOutput)
}

enum DetailViewModelOutput
{
    case isFavorited(Result<(Article, Bool)>)
}
