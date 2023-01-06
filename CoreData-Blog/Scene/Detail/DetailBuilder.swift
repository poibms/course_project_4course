//
//  DetailBuilder.swift
//  CoreData-Blog
//

//

import UIKit

final class DetailBuilder
{
    static func make(with article: Article,
                     _ viewModel: DetailViewModelProtocol) -> DetailViewController
    {
        let storyboard     = UIStoryboard(name: "Detail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        
        viewController.article = article
        viewController.viewModel = viewModel
        
        return viewController
    }
}
