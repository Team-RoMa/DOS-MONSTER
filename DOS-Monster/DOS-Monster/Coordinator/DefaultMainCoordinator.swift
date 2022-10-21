//
//  DefaultMainCoordinator.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/17.
//

import RxRelay

final class DefaultMainCoordinator: MainCoordinator {
//    weak var finishDelegate: CoordinatorFinishDelegate?
//    weak var parentCoordinator: AppCoordinator? ///이것도 delegate 패턴 쓰면 parent가 누군지 알 필요 없어짐
    
    var childCoordinatorMap: [CoordinatorType: Coordinator] = [:]
//    var childCoordinators: [Coordinator] = [] //여기에 append하는식으로 관리하면 push-pop 할 때 마다 계속 쌓이는 경우도 있음
    var navigationController: UINavigationController
    var tabBarController = RootTabBarController()
    let type: CoordinatorType = .main
    
//    var petName: BehaviorRelay<String>
    var petName: String
    
//    let petNameChangeViewController: PetNameChangeViewController
    
    init(navigationController: UINavigationController, petName: String) {
        self.navigationController = navigationController
//        self.petName = BehaviorRelay(value: petName)
        self.petName = petName
    }
    
    func start() {
        let homeCoordinator = DefaultHomeCoordinator(tabBarController: tabBarController, petName: petName)
        let gameCoordinator = DefaultGameCoordinator(tabBarController: tabBarController)
        add(childCoordinator: homeCoordinator)
        add(childCoordinator: gameCoordinator)
        homeCoordinator.start()
        gameCoordinator.start()
        
        navigationController.setViewControllers([tabBarController], animated: true) //루트뷰컨 재설정
    }
//    deinit {
//        print("sadkk")
//    }
}

//extension DefaultMainCoordinator: PetNameChangeCoordinatorFinishDelegate {
//    func finish(with newName: String) {
//        //MainViewModel의 petName 바꿔줘야함 -> Sub ViewModel to Super ViewModel 방식에서 Coordi to Coordi
//        petName.accept(newName)
//        delete(childCoordinator: .petNameChange)
//    }
//}
