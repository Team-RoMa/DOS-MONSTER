//
//  Food.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/09/27.
//

import Foundation
import CoreData

//enum Food {
//    case apple
//    case banana
//
//    var satisfaction: Int {
//        switch self {
//        case .apple:
//            return 1
//        case .banana:
//            return 2
//        }
//    }
//}

//protocol Edible {
//    var satisfaction: Int { get }
//}
//
//struct Food: Edible {
//    var satisfaction: Int
//}
//
//enum Fruits {
//    case apple
//    case banana
//
//    var info: Food {
//        switch self {
//        case .apple:
//            return Food(satisfaction: 1)
//        case .banana:
//            return Food(satisfaction: 2)
//        }
//    }
//}

enum DataFetchError: Error {
    case fileNotFound
    case failToDecode
}

struct FoodList: Decodable {
    let data: [Food]
}

struct Food: Hashable, Codable {
    let name: String
    let emoji: String
    let satisfaction: Int16
}

extension Food: ManagedObjectConvertible {
    func toManagedObejct(in context: NSManagedObjectContext) -> FoodMO {
        let foodMO = FoodMO(context: context)
        foodMO.name = name
        foodMO.emoji = emoji
        foodMO.satisfaction = satisfaction
        return foodMO
    }
}


class FoodDatabase {
//    private var foodNameMap: [String: Food] = [:]
//
//    init() {
//        fetchFoods()
//    }
//
//    func findFood(by name: String) -> Food? {
//        return foodNameMap[name]
//    }
//
//    private func fetchFoods() {
//        requestDataFromBundle { result in
//            switch result {
//            case .success(let foods):
//                foods.forEach { food in
//                    self.foodNameMap[food.name] = food
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    private var foods: [Food] = []
    
    init() {
        fetchSystemFoods()
    }
    
//    func findFood(by name: String) -> Food? {
//        return food
//    }
    
    private func fetchSystemFoods() {
        requestDataFromBundle { result in
            switch result {
            case .success(let foods):
                self.foods = foods
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func requestDataFromBundle(completion: @escaping (Result<[Food], DataFetchError>) -> Void) {
        let parseResult = BundleFileParser<FoodList>.request(fileName: "FoodDatabase", extension: "json")
        switch parseResult {
        case .success(let foodList):
            completion(.success(foodList.data))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

//class FoodDatabase: FoodDatabaseProtocol {
//    let foods: [String: Food] = ["apple": Food(name: "apple", emoji: "🍎", satisfaction: 1),
//                                 "banana": Food(name: "banana", emoji: "🍌", satisfaction: 2),
//                                 "cherry": Food(name: "cherry", emoji: "🍒", satisfaction: 2),
//                                 "mango": Food(name: "mango", emoji: "🥭", satisfaction: 3),
//                                 "grape": Food(name: "grape", emoji: "🍇", satisfaction: 3),
//                                 "watermelon": Food(name: "watermelon", emoji: "🍉", satisfaction: 3),
//                                 "melon": Food(name: "melon", emoji: "🍈", satisfaction: 3),
//                                 "orange": Food(name: "orange", emoji: "🍊", satisfaction: 4),
//                                 "carrot": Food(name: "carrot", emoji: "🥕", satisfaction: 4),
//                                 "chicken": Food(name: "chicken", emoji: "🍗", satisfaction: 4)]
//
//    func findFood(by name: String) -> Food? {
//        return foods[name]
//    }
//}

// for문 돌면서 db에 데이터들이 잘 들어가있는지(만족도가 음수거나 너무 크거나, index가 올바르지 않거나 등) 확인

//protocol FoodDatabaseProtocol {
//    var foods: [String: Food] { get }
//}

//extension FoodDatabaseProtocol {
//    subscript(index: Int) -> Food? {
//        if !foods.indices.contains(index) { return nil }
//        return foods[index]
//    }
//}

//class MockFoodDatabase: FoodDatabaseProtocol {
//    let foods: [String: Food] = ["apple": Food(name: "apple", emoji: "🍎", satisfaction: 1),
//                                 "banana": Food(name: "banana", emoji: "🍌", satisfaction: 2)]
//}
