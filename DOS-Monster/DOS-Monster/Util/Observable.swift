////
////  Observable.swift
////  DOS-Monster
////
////  Created by 김상혁 on 2022/09/29.
////
//
//import Foundation
//
//protocol Disposable {
//    func dispose()
//    func disposed(by disposeBag: DisposeBag)
//}
//
//final class PublishRelay<T>: Disposable {
//    typealias BindElement = (T) -> Void
//
//    private var binders: [BindElement] = []
//
//    func bind(onNext: @escaping BindElement) -> Disposable {
//        binders.append(onNext)
//        return self
//    }
//
//    func accept(_ value: T) {
//        binders.forEach {
//            $0(value)
//        }
//    }
//
////    func bind(to observer: PublishRelay) -> Disposable {
////        return bind(onNext: observer.accept(_:))
//////        return bind { observer.accept($0) } //observer에게 accept해주는 클로저를 bind 걸어둠
////    }
//
//    func dispose() {
//        binders.removeAll()
//    }
//
//    func disposed(by bag: DisposeBag) {
//        bag.insert(self)
//    }
//}
//
//final class BehaviorRelay<T>: Disposable {
//    typealias BindElement = (T) -> Void
//
//    private var binders: [BindElement] = []
//    var value: T
//
//    init(value: T) {
//        self.value = value
//    }
//
//    func bind(onNext: @escaping BindElement) -> Disposable {
//        binders.append(onNext)
//        return self
//    }
//
//    func accept(_ value: T) {
//        binders.forEach {
//            $0(value)
//        }
//    }
//
//    func disposed(by disposeBag: DisposeBag) {
//        disposeBag.insert(self)
//    }
//
//    func dispose() {
//        binders.removeAll()
//    }
//}
//
//final class DisposeBag {
//    private var bag: [Disposable] = []
//
//    func insert(_ observer: Disposable) {
//        bag.append(observer)
//    }
//
//    deinit {
//        bag.forEach {
//            $0.dispose()
//        }
//        bag.removeAll()
//    }
//}
