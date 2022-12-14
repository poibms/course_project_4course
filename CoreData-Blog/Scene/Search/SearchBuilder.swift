//
//  SearchBuilder.swift
//  CoreData-Blog
//

//

import UIKit

final class SearchBuilder
{
    static func make() -> UINavigationController
    {
        let storyboard = UIStoryboard(name: K.Storyboard.search, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: K.Storyboard.search) as! SearchViewController
        
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        viewController.viewModel = SearchViewModel(service: SearchService(stack: app.stack))
        
        return UINavigationController(rootViewController: viewController)
    }
}
