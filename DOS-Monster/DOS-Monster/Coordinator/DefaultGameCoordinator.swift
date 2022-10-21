//
//  DefaultGameCoordinator.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/18.
//

import UIKit

final class DefaultGameCoordinator: GameCoordinator {
    var childCoordinatorMap: [CoordinatorType: Coordinator] = [:]
    var navigationController = UINavigationController()
    var tabBarController: UITabBarController
    var type: CoordinatorType = .game
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let gameViewController = FoodGameViewController()
//        navigationController.setViewControllers([gameViewController], animated: true)
//        navigationController.present(gameViewController, animated: true)
        navigationController.pushViewController(gameViewController, animated: true)
        tabBarController.addViewController(navigationController, animated: true)
    }
}
