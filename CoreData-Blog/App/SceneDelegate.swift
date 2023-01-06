//
//  SceneDelegate.swift
//  CoreData-Blog
//

//

import UIKit

@available(iOS 13.0, *)
final class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions)
    {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//
//        app.router.start(with: windowScene)

        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: scene.coordinateSpace.bounds)
        self.window?.windowScene = scene
        let navigationController = LoginViewController()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

