//
//  PetNameViewModel.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/12.
//

import RxSwift
import RxRelay
import RxCocoa

class PetNameSetupViewModel: ViewModelType {
    weak var coordinator: AppCoordinator?
    private let disposeBag = DisposeBag()
    
    init(coordinator: AppCoordinator?) {
        self.coordinator = coordinator
    }
    
    @discardableResult
    func transform(from input: Input) -> Output {
        let output = Output()
        guard let coordinator = coordinator else { return Output() }
        
        input.nextButtonDidTap
            .withLatestFrom(input.petNameTextFieldDidEdit)
            .map {
                ($0, UserDefaults.Keys.petName)
            }
            .bind(onNext: UserDefaults.standard.set)
            .disposed(by: disposeBag)
        
        input.nextButtonDidTap
            .withLatestFrom(input.petNameTextFieldDidEdit)
            .compactMap { $0 }
            .bind(onNext: coordinator.showMainFlow)
            .disposed(by: disposeBag)
        
        return output
    }
}

extension PetNameSetupViewModel {
    struct Input {
        let petNameTextFieldDidEdit: Observable<String?>
        let nextButtonDidTap: Observable<Void>
    }
    
    struct Output {
        
    }
}
