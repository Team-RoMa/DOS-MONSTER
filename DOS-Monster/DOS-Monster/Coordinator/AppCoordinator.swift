//
//  AppCoordinator.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/17.
//

import Foundation

protocol AppCoordinator: Coordinator {
    func pushPetNameSetupViewController()
    func showMainFlow(with petName: String)
}
