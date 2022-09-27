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

// MARK: - Font
struct AppFontName {
  static let regular = "DungGeunMo"
  static let bold = "DungGeunMo"
}

extension UIFontDescriptor.AttributeName {
  static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {

  @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
  }

  @objc convenience init(myCoder aDecoder: NSCoder) {
    guard
        let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
        let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
        self.init(myCoder: aDecoder)
        return
    }
    var fontName = ""
    switch fontAttribute {
    case "CTFontRegularUsage":
        fontName = AppFontName.regular
    case "CTFontEmphasizedUsage", "CTFontBoldUsage":
        fontName = AppFontName.bold
    default:
        fontName = AppFontName.regular
    }
    self.init(name: fontName, size: fontDescriptor.pointSize)!
  }

  class func overrideInitialize() {
    guard self == UIFont.self else { return }

    if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
        let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
        method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
    }

    if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
        let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
        method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
    }
  }
}
