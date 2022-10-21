//
//  PetNameChangeViewModel.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/17.
//
import RxSwift
import RxRelay

protocol PetNameChangeUseCase {
//    var currentName: BehaviorSubject<String> { get }
    var currentName: BehaviorRelay<String> { get }
    
    func saveChangedName()
    func updateCurrentName(to newName: String)
}

class DefaultPetNameChangeUseCase: PetNameChangeUseCase {
    let currentName: BehaviorRelay<String>
//    let currentName: BehaviorSubject<String> //Subject는 왜 안될까?
    
    init(currentName: String) {
        self.currentName = BehaviorRelay(value: currentName)
//        self.currentName = BehaviorSubject<String>(value: currentName)
    }
    
    func updateCurrentName(to newName: String) {
//        if newName.count > 15 {
//            currentName.onNext(.upperBoundViolation)
//        }
        currentName.accept(newName)
//        currentName.onNext(newName)
        saveChangedName()
    }
    
    func saveChangedName() {
        UserDefaults.standard.set(currentName.value, forKey: UserDefaults.Keys.petName)
    }
}

class PetNameChangeViewModel: ViewModelType {
    private weak var coordinator: HomeCoordinator?
    private let disposeBag = DisposeBag()
    let petNameChangeUseCase: PetNameChangeUseCase
    
    struct Input {
        let petNameTextFieldDidEdit: Observable<String?>
        let nextButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let changedName = BehaviorRelay<String>(value: "")
        let currentName = BehaviorRelay<String>(value: "")
    }
    
    init(coordinator: HomeCoordinator?, petNameChangeUseCase: PetNameChangeUseCase) {
        self.coordinator = coordinator
        self.petNameChangeUseCase = petNameChangeUseCase
    }
    
    func transform(from input: Input) -> Output {
        handle(input: input)
        return createOutput(from: input)
    }
    
    // MARK: - From Input To UseCase(or Output)
    
    private func handle(input: Input) {
        guard let coordinator = coordinator else { return }
        
        input.nextButtonDidTap
            .withLatestFrom(input.petNameTextFieldDidEdit)
            .compactMap { $0 }
            .bind(onNext: petNameChangeUseCase.updateCurrentName)
            .disposed(by: disposeBag)
        
        input.nextButtonDidTap
            .bind(onNext: coordinator.popToRootViewController)
            .disposed(by: disposeBag)
    }
    
    // MARK: - From UseCase(or Input) To Output
    
    private func createOutput(from input: Input) -> Output {
        let output = Output()
        
        petNameChangeUseCase.currentName
            .bind(to: output.currentName)
            .disposed(by: disposeBag)
        
        return output
    }
}

extension PetNameChangeViewModel { //TODO: UseCase Private으로 만들고, 바인딩해주는 함수 제공
//    func bind(to )
}
