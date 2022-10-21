//
//  DefaultAppCoordinator.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/17.
//

import UIKit

final class DefaultAppCoordinator: AppCoordinator {
    
    let type: CoordinatorType = .app
//    weak var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinatorMap: [CoordinatorType: Coordinator] = [:]
    var navigationController: UINavigationController
    
    var savedPetName: String? {
        UserDefaults.standard.string(forKey: UserDefaults.Keys.petName)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        if let petName = savedPetName {
            showMainFlow(with: petName)
        } else {
            pushPetNameSetupViewController()
        }
    }
    
    func pushPetNameSetupViewController() {
        let petNameViewModel = PetNameSetupViewModel(coordinator: self)
        let petNameViewController = PetNameSetupViewController()
        petNameViewController.viewModel = petNameViewModel
        navigationController.pushViewController(petNameViewController, animated: true)
    }
    
    func showMainFlow(with petName: String) {
        let mainCoordinator = DefaultMainCoordinator(navigationController: navigationController, petName: petName)
        add(childCoordinator: mainCoordinator)
        mainCoordinator.start()
    }
}

//extension DefaultAppCoordinator: CoordinatorFinishDelegate {
//    func finish(childCoordinator: Coordinator) {
////        switch childCoordinator.type { //추상화가능할듯?
////        case .main:
////            break //FIXME: -
////        case .petName:
////            //완전히 삭제할거면 이거 해주고, 아니면(얘로부터 push되어서 언제든 얘로 다시 돌아갈 수 있을 때)는 하지말기
////            deleteChildCoordinator(by: type)
////
//////        case .petNameChange(let newName):
//////            deleteChildCoordinator(by: type)
////////            childCoordinator.navigationController.popToRootViewController(animated: true) 여기서 해주는건 왜 안됨...???;;;
//////            showMainFlow(with: newName)
////        default:
////            break
////        }
//        deleteChildCoordinator(by: childCoordinator.type)
//    }
//}

//extension DefaultAppCoordinator: PetNameSetupCoordinatorDelegate {
//    func pushToMainViewController(with petName: String) {
//        showMainFlow(with: petName)
//        delete(childCoordinator: .petName) //이제 더 이상 쓸 일 없으니 deinit
//    }
//}
