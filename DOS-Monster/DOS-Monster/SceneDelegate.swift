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
        let tabbarController = UITabBarController()
        tabbarController.tabBar.backgroundColor = .systemGray4
        tabbarController.tabBar.tintColor = .black
        tabbarController.tabBar.isTranslucent = false
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key: Any], for: .normal)
        
        let mainViewController = ViewController()
        mainViewController.title = "Home"
        let gameViewController = GameViewController()
        gameViewController.title = "Game"
        
        tabbarController.setViewControllers([mainViewController, gameViewController], animated: false)
        
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
    }
}

// MARK: - GameViewController
class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}
