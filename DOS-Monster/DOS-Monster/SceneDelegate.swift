//
//  SceneDelegate.swift
//  DOS-Monster
//
//  Created by Sujin Jin on 2022/09/20.
//

import RxSwift
import RxRelay

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var appCoordinator: AppCoordinator?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        UIFont.overrideInitialize()
        let navigationController = UINavigationController()
        appCoordinator = DefaultAppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

//protocol CoordinatorFinishDelegate: AnyObject {
//    func finish(childCoordinator: Coordinator) //parent가 자신의 child가 finish될 때 실행하는 함수
//}


enum CoordinatorType: Hashable {
    case app
    case main
    case petName
    case petNameChange
    case home
    case game
}
