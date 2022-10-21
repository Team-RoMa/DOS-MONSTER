//
//  FoodCollectionCellViewModel.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/04.
//

import RxSwift
import RxRelay

class FoodCollectionCellViewModel: ViewModel {
    private let disposeBag = DisposeBag()
    
    struct Action {
        let cellViewDidLoad = PublishRelay<Void>()
    }
    
    struct State {
        let loadedfood = PublishRelay<Food>()
        let loadedCount = PublishRelay<Int>()
    }
    
    let action = Action()
    let state = State()
    
    init(food: Food, count: Int) {
        action.cellViewDidLoad.bind { [weak self] in
            self?.state.loadedfood.accept(food)
            self?.state.loadedCount.accept(count)
        }.disposed(by: disposeBag)
    }
}
