//
//  HomeBuilder.swift
//  CoreData-Blog
//

//

import UIKit

final class HomeBuilder
{
    static func make() -> UINavigationController
    {
        let storyboard = UIStoryboard(name: K.Storyboard.home, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: K.Storyboard.home) as! HomeViewController
        
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        viewController.viewModel = HomeViewModel(service: HomeService(stack: app.stack))
        
        return UINavigationController(rootViewController: viewController)
    }
}
