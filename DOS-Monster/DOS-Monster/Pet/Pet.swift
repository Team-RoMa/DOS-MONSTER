//
//  Pet.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/09/27.
//

import Foundation


//struct ExpUsecase {
//    let database = ExpDatabase()
//
//    func increase(currentLevel: Int, currentExp: Int, increase amount: Int) -> (incrementLevel: Int, newLevel: Int, newExp: Int) { //1레벨 경험치 100 + 150 = 2레벨 경험치 50
//        if currentLevel == LevelConstant.max {
//            return (0, LevelConstant.max, 0)
//        }
//
//        //현재 레벨에서 채워야할 총 경험치 통
//        let totalExpForLevelUp = database.table[currentLevel]
//
//        //통을 다 채우기 위한 나머지 경험치
//        var remainingExpForLevelUp = totalExpForLevelUp - currentExp
//
//        var currentLevel = currentLevel
//        var currentExp = currentExp
//
//        while currentLevel > LevelConstant.max {
//            if amount < remainingExpForLevelUp {
//                return (currentLevel - currentLevel, currentLevel, amount + currentExp)
//            }
//
//            currentExp = amount - database.table[currentLevel]
//            currentLevel += 1
//
//            if currentLevel == LevelConstant.max {
//                return (currentLevel - currentLevel, currentLevel, 0)
//            }
//
//            remainingExpForLevelUp = database.table[currentLevel] - currentExp
//        }
//    }
//}
//
//struct Level {
//    var currentLevel: Int
//    var currentExp: Int
//    //        현재 레벨: 2
//    //        현재 경험치: 300 / 600 (50%)
//    //        레벨 업 (+3)! 현재 레벨 5
//
//    var totalExpForLevelUp: Int? {
//        return expTable[currentLevel]
//    }
//
//    private var remainingExpForLevelUp: Int? {
//        guard let totalExpForLevelUp = totalExpForLevelUp else { return nil }
//        return totalExpForLevelUp - currentExp
//    }
//
//    private var expTable: [Int: Int] {
//        return calculateExpTable(start: LevelConstant.start, max: LevelConstant.max)
//    }
//
//    mutating func increase(exp: Int) { //1레벨 경험치 100 // 2레벨 경험치 150 // 300
//        guard let remainingExpForLevelUp = remainingExpForLevelUp else { return }
//
//        if currentLevel == LevelConstant.max {
//            return
//        }
//
//        if exp < remainingExpForLevelUp {
//            self.currentExp += exp
//            return
//        }
//
//        let overflowedExp = exp - remainingExpForLevelUp
//        currentLevel += 1
//        increase(exp: overflowedExp)
//    }
//
////    func provideLevelInfo() -> (newLevel: Int, increment: Int) {
////        guard let totalExpForLevelUp = totalExpForLevelUp else { return }
////        //        closure(currentExp, totalExpForLevelUp, currentLevel)
////        return
////    }
//}
//
//class ExpDatabase {
//    let table: [Int] = []
//
//    init() {
//        let startLevel = LevelConstant.start
//        let maxLevel = LevelConstant.max
//        table = setUpExpTable(start: startLevel, max: maxLevel)
//    }
//
//    private func setUpExpTable(start: Int, max: Int) -> [Int] {
//        var currentLevel = start
//        var exps: [Int] = [0]
//
//        for _ in start...max {
//            exps.append(currentLevel * (currentLevel + 1) * 25)
//            currentLevel += 1
//        }
//
//        return exps
//    }
//}


//struct PetSatietyUsecase {
//
//    let pet = Pet(name: "asd")
//
//    let satietyController = PetSatietyController()
//
//    func feed(food: Food) -> PetResponse {
//        switch pet.isSatietyMax {
//        case true:
//            return .alreadyMax
//        case false:
//            let newSatiety = satietyController.increase(satiety: pet.satiety, by: food.satisfaction)
//            return .levelUp(increment: increment, newLevel: newSatiety.rawValue)
//        }
//    }
//
//    func updatePetSatiety(to newSatiety: Pet.Satiety) {
//
//    }
//
//}
//
struct PetSatietyUsecase {
//    func increase(satiety: Pet.Satiety, by amount: Int) -> Pet.Satiety {
//        return satiety.increase(by: amount)
//    }
//
//    func decrease(satiety: Pet.Satiety, by amount: Int) -> Pet.Satiety {
//        return satiety.decrease(by: amount)
//    }
    
    func isMax(satiety: Pet.Satiety) -> Bool {
        return satiety.isMax
    }
    
    func increase(satiety: Pet.Satiety, by amount: Int) -> (increment: Int, newSatiety: Pet.Satiety) {
        let (increment, newSatiety) = satiety.increase(by: amount)
        return (increment, newSatiety)
    }
    
//    func decrease(satiety: Pet.Satiety, by amount: Int) -> Pet.Satiety {
//        return satiety.decrease(by: amount)
//    }
}
//
////struct PetASDUsecase {
//    func `do`(behavior: Behavior, to pet: Pet.Closeness) -> PetResponse {
//        let response = closenessLevel.increase(by: behavior.satisfaction)
//        let increment = response.increment
//        switch increment {
//        case 0:
//            return .alreadyMax
//        default:
//            let newLevel = response.newLevel
//            closenessLevel = newLevel
//            return .levelUp(increment: increment, newLevel: newLevel.rawValue)
//        }
//    }
////}

struct Pet {
    let name: String
//    var level = Level(currentLevel: LevelConstant.start, currentExp: LevelConstant.startExp)
    let satiety: Satiety
    let closeness: Closeness
//
//    var isSatietyMax: Bool {
//        return satiety.isMax
//    }

    init(name: String, satiety: Satiety = .moderate, closeness: Closeness = .awkward) {
        self.name = name
        self.satiety = satiety
        self.closeness = closeness
    }
//
//    init(pet: Pet) {
//        self.name = pet.name
//        self.satiety = pet.satiety
//        self.closeness = pet.closeness
//    }
    
    // MARK: Mutating Level

//    mutating func increaseExp(by amount: Int) -> PetResponse {
//        level.increase(exp: amount)
//
//        level.provideLevelInfo(to: { currentExp, currentLevel, totalExpForLevelUp in
//            return .levelUp(increment: <#T##Int#>, newLevel: <#T##Int#>)
//        })
//        return .alreadyMax
//    }

    // MARK: Mutating Satiety

//    mutating func eat(food: Food) -> PetResponse {
//        let response = satietyLevel.increase(by: food.satisfaction)
//        let increment = response.increment
//        switch increment {
//        case 0:
//            return .alreadyMax
//        default:
//            let newLevel = response.newLevel
//            satietyLevel = newLevel
//            return .levelUp(increment: increment, newLevel: newLevel.rawValue)
//        }
//    }

//    mutating func starve(by level: Int) {
//        satietyLevel = satietyLevel.decrease(by: level)
//    }

    // MARK: Mutating Closeness
//
//    mutating func subjected(to behavior: Behavior) -> PetResponse {
//        let response = closenessLevel.increase(by: behavior.satisfaction)
//        let increment = response.increment
//        switch increment {
//        case 0:
//            return .alreadyMax
//        default:
//            let newLevel = response.newLevel
//            closenessLevel = newLevel
//            return .levelUp(increment: increment, newLevel: newLevel.rawValue)
//        }
//    }

//    func updateSatietyLevel(_ closure: (Int) -> Void) {
//        closure(satietyLevel.rawValue)
//    }
//
//    func updateClosenessLevel(_ closure: (Int) -> Void) {
//        closure(closenessLevel.rawValue)
//    }
}

extension Pet {
    enum Satiety: Int, LevelType {
        case starving = 1
        case hungry
        case moderate
        case full
        case stuffed
    }
}

extension Pet {
    enum Closeness: Int, LevelType {
        case awkward = 1
        case normal
        case close
        case bestFriend
        case soulMate
    }
}

//protocol Pettable {
//    var name: String
//    var level = Level(currentLevel: LevelConstant.start, currentExp: LevelConstant.startExp)
//    var satietyLevel: Satiety = .moderate
//    var closenessLevel: Closeness = .awkward
//
//}
//
//struct Pet: Pettable {
//    var name: String
//    var level = Level(currentLevel: LevelConstant.start, currentExp: LevelConstant.startExp)
//    var satietyLevel: Satiety = .moderate
//    var closenessLevel: Closeness = .awkward
//
//    init(name: String) {
//        self.name = name
//    }
//
//    // MARK: Mutating Level
//
//    mutating func increaseExp(by amount: Int) -> PetResponse {
//        level.increase(exp: amount)
//
//        level.provideLevelInfo(to: { currentExp, currentLevel, totalExpForLevelUp in
//            return .levelUp
//        })
//        return .alreadyMax
//    }
//
//    // MARK: Mutating Satiety
//
//    mutating func eat(food: Food) -> PetResponse {
//        let response = satietyLevel.increase(by: food.satisfaction)
//        let increment = response.increment
//        switch increment {
//        case 0:
//            return .alreadyMax
//        default:
//            let newLevel = response.newLevel
//            satietyLevel = newLevel
//            return .levelUp(increment: increment, newLevel: newLevel.rawValue)
//        }
//    }
//
//    mutating func starve(by level: Int) {
//        satietyLevel = satietyLevel.decrease(by: level)
//    }
//
//    // MARK: Mutating Closeness
//
//    mutating func subjected(to behavior: Behavior) -> PetResponse {
//        let response = closenessLevel.increase(by: behavior.satisfaction)
//        let increment = response.increment
//        switch increment {
//        case 0:
//            return .alreadyMax
//        default:
//            let newLevel = response.newLevel
//            closenessLevel = newLevel
//            return .levelUp(increment: increment, newLevel: newLevel.rawValue)
//        }
//    }
//
//    func updateSatietyLevel(_ closure: (Int) -> Void) {
//        closure(satietyLevel.rawValue)
//    }
//
//    func updateClosenessLevel(_ closure: (Int) -> Void) {
//        closure(closenessLevel.rawValue)
//    }
//}
//
//enum Satiety: Int, LevelType {
//    case starving = 1
//    case hungry
//    case moderate
//    case full
//    case stuffed
//}
//
//enum Closeness: Int, LevelType {
//    case awkward = 1
//    case normal
//    case close
//    case bestFriend
//    case soulMate
//}
//
//struct MockPet: Pettable {
//    var name: String
//    var level: Level
//    var satietyLevel: Satiety
//    var closenessLevel: Closeness
//}
