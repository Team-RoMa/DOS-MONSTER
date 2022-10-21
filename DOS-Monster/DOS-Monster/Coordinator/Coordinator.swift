//
//  Coordinator.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/17.
//

import UIKit

protocol Coordinator: AnyObject {
//    associatedtype finishDelegate
//    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var childCoordinatorMap: [CoordinatorType: Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var `type`: CoordinatorType { get }
    
    func start()
}

extension Coordinator {
//    func finish() { //childCoordinator가 자신이 finish될 때(자신의 화면이 끝났고 더 이상 필요 없을 때) 호출
////        childCoordinatorMap.removeAll() <- 필요없음, 어차피 self가 없어지면 self가 참조하고있는 프로퍼티도 다 없어짐
//
//        //finishDelegate(== 자신을 소유한 parentCoordiator)에게 자신이 finish됨에 대한 delegate 함수 호출
//        finishDelegate?.finish(childCoordinator: self)
//        //delegate는 self로 넘어온 childCoordinator를 삭제하고 이후에 보여줘야할 뷰 흐름을 실행
//    }
//
    
    func add(childCoordinator: Coordinator) {
        childCoordinatorMap[childCoordinator.type] = childCoordinator
    }
    
    func delete(childCoordinator type: CoordinatorType) {
        childCoordinatorMap.removeValue(forKey: type)
    }
    
//    func finish() {
//        parentCoordinator.removeMe()
//        removeAllChildCoordinator()
//    }
}
