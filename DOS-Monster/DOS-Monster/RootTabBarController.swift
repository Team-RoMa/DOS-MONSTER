//
//  RootTabBarController.swift
//  DOS-Monster
//
//  Created by Sujin Jin on 2022/09/27.
//

import UIKit

class RootTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setupTabbar()
    }
    
    func setupTabbar() {
        tabBar.backgroundColor = .systemGray4
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key: Any], for: .normal)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is GameViewController {
            self.present(GameViewController(), animated: true)
            return false
        } else {
            return true
        }
    }
}
