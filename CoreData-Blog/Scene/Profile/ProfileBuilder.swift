//
//  ProfileBuilder.swift
//  CoreData-Blog
//

//

import UIKit

final class ProfileBuilder
{
    static func make() -> UINavigationController
    {
        let storyboard     = UIStoryboard(name: K.Storyboard.profile, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: K.Storyboard.profile) as! ProfileViewController
        
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 3)
        viewController.viewModel = ProfileViewModel(service: ProfileService(stack: app.stack))

        return UINavigationController(rootViewController: viewController)
    }
}
