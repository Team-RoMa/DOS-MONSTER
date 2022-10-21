//
//  DefaultHomeCoordinator.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/18.
//

import RxSwift
import RxRelay

enum HomeViewControllerType {
    case home
    case food
    case petNameChange(viewModel: PetNameChangeViewModel)
}

final class DefaultHomeCoordinator: HomeCoordinator {
    var childCoordinatorMap: [CoordinatorType: Coordinator] = [:]
    var navigationController = UINavigationController()
    var tabBarController: UITabBarController
    var type: CoordinatorType = .home
    
    var petName: String // homeViewModel의 속성으로 넣고, 상위 coordinator에서 homeViewModel 만들때 넣어주기
    private let disposeBag = DisposeBag()
    
    init(tabBarController: UITabBarController, petName: String) {
        navigationController.setNavigationBarHidden(true, animated: true)
        self.tabBarController = tabBarController
        self.petName = petName
    }
    
    func pushViewController(by homeViewType: HomeViewControllerType) {
        switch homeViewType {
        case .home:
            start() // homeViewModel도 상위 coordinator에서 주입받기
        case .food:
            presentFoodViewController()
        case .petNameChange(let viewModel):
            pushToPetNameChangeViewController(with: viewModel)
//            let petNameChangeViewController = PetNameChangeViewController()
//            petNameChangeViewController.viewModel = viewModel
//            navigationController.pushViewController(petNameChangeViewController, animated: true)
        }
        
//        let petNameChangeViewController = PetNameChangeViewController()
////        let petNameChangeViewModel = PetNameChangeViewModel(coordinator: self, currentName: currentName)
////        let petNameChangeViewModel = PetNameChangeViewModel(
////            coordinator: self,
////            petNameChangeUseCase: DefaultPetNameChangeUseCase(currentName: currentName)
////        )
//        petNameChangeViewController.viewModel = petNameChangeViewModel
//        navigationController.pushViewController(petNameChangeViewController, animated: true)
    }
    
    func start() {
        let homeViewModel = HomeViewModel(
            coordinator: self,
            homeUseCase: DefaultHomeUseCase(petName: petName, foodRepository: DefaultFoodRepository())
        )
        let homeViewController = HomeViewController()
        homeViewController.viewModel = homeViewModel
        navigationController.setViewControllers([homeViewController], animated: true)
        tabBarController.addViewController(navigationController, animated: true)
    }
    
    func popToRootViewController() {
        navigationController.popToRootViewController(animated: true)
    }
    
    private func pushToPetNameChangeViewController(with viewModel: PetNameChangeViewModel) {
        let petNameChangeViewController = PetNameChangeViewController()
//        let petNameChangeViewModel = PetNameChangeViewModel(
//            coordinator: self,
//            petNameChangeUseCase: DefaultPetNameChangeUseCase(currentName: currentName)
//        )
        petNameChangeViewController.viewModel = viewModel
        navigationController.pushViewController(petNameChangeViewController, animated: true)
    }
    
    private func presentFoodViewController() {
        let foodViewController = FoodViewController()
        let foodViewModel = FoodViewModel(
            foodUseCase: DefaultFoodUseCase(
                foodRepository: DefaultFoodRepository()
            )
        )
        foodViewController.viewModel = foodViewModel
        navigationController.present(foodViewController, animated: true)
    }
    
    // TODO: DI Container 객체 생성해서 아래 메소드 따로 빼기
    
    func makePetNameChangeViewModel(with petName: String) -> PetNameChangeViewModel {
        PetNameChangeViewModel(
            coordinator: self,
            petNameChangeUseCase: DefaultPetNameChangeUseCase(
                currentName: petName
            )
        )
    }
}
