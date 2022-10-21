//
//  MainViewModel.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/04.
//

import RxSwift
import RxRelay

struct PetFoodResponse {
    let increment: Int
    let newSatiety: Pet.Satiety
    let petName: String
    let isLevelUp: Bool
}

class PetDatabase {
    var pet: Pet
    
//    func requestDataFromBundle(completion: @escaping (Result<[Food], DataFetchError>) -> Void) {
//        
//        // 내부에 JSON 파일로 저장하지 말고 서버에 저장해서 불러오기?
////        guard let url = Bundle.main.url(forResource: "FoodDatabase", withExtension: "json"),
////              let data = try? Data(contentsOf: url) else {
////            completion(.failure(.fileNotFound))
////            return
////        }
////
////        if let decodedData = JSONConvertService<FoodList>.decode(data: data) {
////            let foods = decodedData.data
////            completion(.success(foods))
////        } else {
////            completion(.failure(.failToDecode))
////        }
//        
//        let parseResult = BundleFileParser<FoodList>.request(fileName: "FoodDatabase", extension: "json")
//        switch parseResult {
//        case .success(let foodList):
//            completion(.success(foodList.data))
//        case .failure(let error):
//            completion(.failure(error))
//        }
//    }
    
    private let pet포만감Usecase = PetSatietyUsecase()
    
    init(petName: String) {
        self.pet = Pet(name: petName)
    }
//    (increment: Int, newSatiety: Pet.Satiety)
    func increase포만감(by amount: Int) -> PetFoodResponse {
        
        let response = pet포만감Usecase.increase(satiety: pet.satiety, by: amount)
        let newPet = Pet(name: pet.name, satiety: response.newSatiety, closeness: pet.closeness)
        let isLevelUp = pet.satiety != newPet.satiety
        
        pet = newPet
        
        return PetFoodResponse(increment: response.increment,
                               newSatiety: response.newSatiety,
                               petName: pet.name,
                               isLevelUp: isLevelUp)
    }
}

/// 코어 데이터에서 사용자의 Food 목록을 fetch
///     - nil이면 '음식 목록이 비었습니다' (한 번도 값 안넣으면 nil? 0개면 nil? 걍 배열로 가져와서 empty면 없다고 해야할까)
///     - 값이 있으면 배열로 넘겨줌

class UserFoodRepository {
    private let foodDatabase = FoodDatabase()
    
    var userFoodCountMap = ["Apple": 3,
                            "Banana": 2,
                            "Orange": 4,
                            "Grape": 2,
                            "Watermelon": 3,
                            "Melon": 2,
                            "Blueberry": 1,
                            "Kiwi": 5,
                            "Chicken": 1] // CoreData로 저장
    
//    func eatFood(name: String) -> Int {
//        guard let count = userFoodCountMap[name] else { return 0 }
//        userFoodCountMap[name] = count - 1 <= 0 ? nil : count - 1
//        return foodDatabase.findFood(by: name)?.satisfaction ?? 0
//    }
    
//    func requestUserFoodData() -> [Food: Int] { // CoreData에서 찾아서 불러오기
//        return userFoodCountMap.reduce(into: [Food: Int]()) { partialResult, element in
//            let foodName = element.key
//            let count = element.value
//            guard let food = foodDatabase.findFood(by: foodName) else { return }
//            partialResult[food] = count
//        }
//    }
}

protocol HomeUseCase {
//    var petName: PublishRelay<String> { get }
//    var petName: BehaviorRelay<String> { get }
    var petName: BehaviorSubject<String> { get }
    func fetchFoodCountMap()
//    func appendFood(completion: @escaping (() -> Void))
    func appendFood()
//    func fetchLogs()
}

class DefaultHomeUseCase: HomeUseCase {
//    let petName = PublishRelay<String>() //왜 안됨?????????????????????????????????????????????????
//    let petName: BehaviorRelay<String>
    
    let foodRepository: FoodRepository
    
    let petName: BehaviorSubject<String>
    let foodCountMap = BehaviorSubject<[Food: Int]>(value: [:])
    
    init(petName: String, foodRepository: FoodRepository) {
//        self.petName.accept(petName) //왜 안됨?????????????????????????????????????????????????
//        self.petName = BehaviorRelay<String>(value: petName)
        self.petName = BehaviorSubject<String>(value: petName)
        self.foodRepository = foodRepository
    }
    
    func fetchFoodCountMap() {
        let foods = foodRepository.fetchUserFoods()
        print(foods)
    }
    
    func appendFood() {
        foodRepository.append(food: Food(name: "Apple", emoji: "🍎", satisfaction: 1), completion: nil)
    }
}

class HomeViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    
    // [갖고있는 음식 이름(key): 음식 개수(value)]
    // 1. CoreData에서 불러오는 방식으로 바꾸기
    // 2. key를 음식 이름 말고 다른걸로 할 만한 거 없나
    
    private weak var coordinator: HomeCoordinator?
    private let homeUseCase: HomeUseCase
    
//    private let petDatabase: PetDatabase
//    private var userDBFood: [String: Int] = [:]
    
    private var foodCountMap: [Food: Int] = [:]
    
    struct Input {
        let feedButtonDidTap: Observable<Void>
        let petNameChangeButtonDidTap: Observable<Void>
//        let foodSelected: Observable<String>
    }
    
    struct Output {
        let petName = BehaviorRelay<String>(value: "")
//        let loadedFoods = BehaviorRelay<[Food: Int]>(value: [:])
//        let presentFoodView = PublishRelay<FoodViewModel>()
//        let satietyChanged = PublishRelay<Int>()
//        let log = PublishRelay<String>()
    }
    
    init(coordinator: HomeCoordinator?, homeUseCase: HomeUseCase) {
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
    }
    
    func transform(from input: Input) -> Output {
        handle(input: input)
        return createOutput(from: input)
    }
    
    // MARK: - From Input To UseCase(or Output)
    
    private func handle(input: Input) {
        guard let coordinator = coordinator else { return }
        
        let petNameChangeViewModel = input.petNameChangeButtonDidTap
            .withLatestFrom(homeUseCase.petName)
            .map {
                coordinator.makePetNameChangeViewModel(with: $0)
            }
            .share()
        
        petNameChangeViewModel
            .map {
                .petNameChange(viewModel: $0)
            }
            .bind(onNext: coordinator.pushViewController)
            .disposed(by: disposeBag)
        
        petNameChangeViewModel
            .flatMap { // map은 왜 안될까
                $0.petNameChangeUseCase.currentName
            }
            .bind(to: homeUseCase.petName)
            .disposed(by: disposeBag)
        
        homeUseCase.appendFood()
        
        let foodViewModel = input.feedButtonDidTap
            .bind(onNext: homeUseCase.fetchFoodCountMap)
            .disposed(by: disposeBag)
//            .withLatestFrom(homeUseCase)
    }
    
    // MARK: - From UseCase(or Input) To Output
    
    private func createOutput(from input: Input) -> Output {
        let output = Output()
        
        homeUseCase.petName
            .bind(to: output.petName)
            .disposed(by: disposeBag)
        
        return output
    }
    
//    func transform(from input: Input) -> Output {
//        let output = Output()
//        guard let coordinator = coordinator else { return output }
//
//        // Input
//
//        let viewModel = input.petNameChangeButtonDidTap
//            .withLatestFrom(homeUseCase.petName)
//            .map {
//                coordinator.makePetNameChangeViewModel(with: $0)
//            }
//            .share()
//
//        viewModel
//            .map {
//                .petNameChange(viewModel: $0)
//            }
//            .bind(onNext: coordinator.pushViewController)
//            .disposed(by: disposeBag)
//
//        viewModel
//            .flatMap { // map은 왜 안될까
//                $0.petNameChangeUseCase.currentName
//            }
//            .bind(to: homeUseCase.petName)
//            .disposed(by: disposeBag)
//
////        input.petNameChangeButtonDidTap.bind { [weak self] in
////            guard let self = self else { return }
////            self.coordinator?.pushViewController(by: .petNameChange(viewModel: viewModel))
////        }.disposed(by: disposeBag)
//
////        input.feedButtonDidTap.bind { [weak self] in
////            self?.coordinator?.presentFoodViewController()
////        }.disposed(by: disposeBag)
//
//        // Output
//
//        homeUseCase.petName
//            .bind(to: output.petName)
//            .disposed(by: disposeBag)
//
//        return output
//    }
    
}
//    private func handle(input: Input) {
//        guard let coordinator = coordinator else { return }
//
//
////        input.feedButtonTapped
////            .bind(to: coordinator?.pushToFoodViewController) //이거 왜 안됨?
////            .disposed(by: disposeBag)
//
//    }
//
//    private func createOutput(from input: Input) -> Output {
//
//
//        homeUseCase.petName
//            .bind(to: output.petName)
//            .disposed(by: disposeBag)
//
//
////        petNameChangeUseCase.currentName
////            .bind(to: output.currentName)
////            .disposed(by: disposeBag)
//
//
//
//        return output
//    }
    
//        print("db: \(userDBFood)")
//        self.petDatabase = PetDatabase(petName: petName)
        
//        state.petName.accept(coordinator.state.petName.value)
        
//        action.changePetNameButtonTapped
//            .bind {
//                coordinator?.pushToPetNameChangeViewController(with: self.state.petName)
//            }
//            .disposed(by: disposeBag)
        
//        state = State(navigationTitle: petName)
        
//        let foodViewModel = action.feedButtonTapped
//            .compactMap { [weak self] in
//                self?.userFoodRepository.requestUserFoodData()
//            }
//            .map { FoodViewModel(foodCountMap: $0) }
//            .share()
//
//        foodViewModel
//            .bind(to: state.presentFoodView)
//            .disposed(by: disposeBag)
//
//        let feedResult = foodViewModel.flatMap {
//            $0.action.selectButtonTapped
//        }
//        .map { [unowned self] name in
//            self.userFoodRepository.eatFood(name: name)
//        }
//        .map { [unowned self] satiety in
//            self.petDatabase.increase포만감(by: satiety)
//        }
//        .share()
//
//        feedResult
//            .map { $0.newSatiety.rawValue }
//            .bind(to: state.satietyChanged)
//            .disposed(by: disposeBag)
        
        // TODO: 여기서부터 다시
//        feedResult
//            .map { $0.increment }
//
//            .bind(to: state.log)
//            .disposed(by: disposeBag)
        
//        .compactMap { [unowned self] in
//            self.userDBFood[$0]
//        }
//        .map { $0 - 1 }
//        .bind { [unowned self] in
//            self.userDBFood[name] = $0
    
        
//        action.foodSelected.bind { [weak self] foodName in
//            guard let selectedFoodCount = self?.userDBFood[foodName], selectedFoodCount > 0 else { return }
//            self?.userDBFood[foodName] = selectedFoodCount - 1
//        }.disposed(by: disposeBag)
//    }
//}
