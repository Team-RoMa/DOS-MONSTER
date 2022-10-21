//
//  UITabBarController+Extension.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/18.
//

import UIKit

extension UITabBarController {
    func addViewController(_ viewController: UIViewController, animated: Bool) {
        var currentViewControllers = viewControllers ?? []
        currentViewControllers.append(viewController)
        setViewControllers(currentViewControllers, animated: animated)
    }
}
