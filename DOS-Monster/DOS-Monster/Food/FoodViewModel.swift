//
//  FoodViewModel.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/04.
//

import RxSwift
import RxRelay
import CoreData

protocol FoodRepository {
//    var foodCountMap: BehaviorSubject<[Food: Int]> { get }
    
    func fetchUserFoods() -> [Food]
    func append(food: Food, completion: (() -> Void)?)
//    func feed(food: Food, completion: (() -> Void)?)
//    func feedFood(at indexPath: IndexPath, completion: (() -> Void)?)
}

extension FoodRepository {
    func append(food: Food) {
        append(food: food, completion: nil)
    }
}

class DefaultFoodRepository: FoodRepository {
    func fetchUserFoods() -> [Food] {
        let request: NSFetchRequest<FoodMO> = FoodMO.fetchRequest()
        let sortedBySatisfaction = NSSortDescriptor(key: #keyPath(FoodMO.satisfaction), ascending: true)
        request.sortDescriptors = [sortedBySatisfaction]
        let foods = CoreDataManager.shared.fetch(request: request).map { $0.toEntity() }
        return foods
    }
    
    func append(food: Food, completion: (() -> Void)? = nil) {
        CoreDataManager.shared.create(from: food, completion: completion)
    }
    
//    func feed(food: Food, completion: (() -> Void)?) {
//        let foodMO = food.toManagedObejct(in: CoreDataManager.shared.mainContext)
//        let currentCount = foodMO.count
//
//        if currentCount > 0 {
//            CoreDataManager.shared.update(foodMO: foodMO, count: currentCount - 1, completion: completion)
//        } else {
//            CoreDataManager.shared.delete(object: foodMO, completion: completion)
//        }
//    }
}

protocol FoodUseCase {
    
}

class DefaultFoodUseCase: FoodUseCase {
    private let foodRepository: FoodRepository
    
    init(foodRepository: FoodRepository) {
        self.foodRepository = foodRepository
    }
    
//    func fetchUserFoods() -> [Food] {
//
//    }
}

class FoodViewModel: ViewModelType {
    private let foodUseCase: FoodUseCase
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let exitButtonDidTap: Observable<Void>
        let selectedButtonDidTap: Observable<IndexPath>
    }
    
    struct Output {
        let foodCountMap = BehaviorRelay<[Food: Int]>(value: [:])
    }
    
    init(foodUseCase: FoodUseCase) {
        self.foodUseCase = foodUseCase
    }
    
    func transform(from input: Input) -> Output {
        input.viewDidLoad
            .bind { [weak self] in
                guard let self = self else { return }
                self.foodUseCase
            }
        
//        let foods = foodUseCase.fetchUserFoods()
//        print(foods)
//
//        let asd = Food(name: "akokokokokossd", emoji: "em", satisfaction: 3)
//        foodUseCase.append(food: asd)
//
//        let newfoods = foodUseCase.fetchUserFoods()
//        print(newfoods)
        
        let output = Output()
        
        return output
    }
}
