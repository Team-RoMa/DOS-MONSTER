//
//  HomeCoordinator.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/18.
//

import RxRelay

protocol HomeCoordinator: Coordinator {
//    func pushToPetNameChangeViewController(with viewModel: PetNameChangeViewModel)
//    func presentFoodViewController()
//    func popToMainViewController()
    
    func pushViewController(by homeViewType: HomeViewControllerType)
    func popToRootViewController()
    func makePetNameChangeViewModel(with petName: String) -> PetNameChangeViewModel
}
