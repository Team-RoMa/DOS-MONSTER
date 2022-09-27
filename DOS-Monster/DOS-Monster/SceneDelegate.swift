//
//  SceneDelegate.swift
//  DOS-Monster
//
//  Created by Sujin Jin on 2022/09/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        UIFont.overrideInitialize()
        
        let mainViewController = ViewController()
        mainViewController.title = "Home"
        let gameViewController = GameViewController()
        gameViewController.title = "Game"
        
        let tabbarController = RootTabBarController()
        tabbarController.setViewControllers([mainViewController, gameViewController], animated: false)
        
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
    }
}
