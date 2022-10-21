//
//  MVVMInterface.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/04.
//

import Foundation

enum ViewModelTable {
    static var viewModelMap = [String: AnyObject?]()
}

protocol ViewModel: AnyObject { //TODO: 지우기
    associatedtype Action
    associatedtype State
    
    var action: Action { get }
    var state: State { get }
}

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input) -> Output
}

protocol ViewType: AnyObject {
    associatedtype ViewModel
    func bind(to viewModel: ViewModel)
}

extension ViewType {
    var identifier: String {
        return String(describing: self)
    }
    
    var viewModel: ViewModel? {
        get {
            guard let viewModel = ViewModelTable.viewModelMap[identifier] as? ViewModel else {
                return nil
            }
            return viewModel
        } set {
            if let viewModel = newValue {
                bind(to: viewModel)
            }
            ViewModelTable.viewModelMap[identifier] = newValue as? AnyObject
        }
    }
}

//protocol ViewModelType {
//    associatedtype Input
//    associatedtype Output
//
//    func transform(from input: Input) -> Output
//}
//
//protocol ViewType: AnyObject {
//    associatedtype ViewModel
//    func bind(to viewModel: ViewModel)
//}
//
//extension ViewType {
//    var identifier: String {
//        return String(describing: self)
//    }
//
//    var viewModel: ViewModel? {
//        get {
//            guard let viewModel = ViewModelTable.viewModelMap[identifier] as? ViewModel else {
//                return nil
//            }
//            return viewModel
//        } set {
//            if let viewModel = newValue {
//                bind(to: viewModel)
//            }
//            ViewModelTable.viewModelMap[identifier] = newValue as? AnyObject
//        }
//    }
//}
