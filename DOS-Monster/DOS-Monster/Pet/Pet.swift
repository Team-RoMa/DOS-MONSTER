//
//  Pet.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/09/27.
//

import Foundation

struct Pet {
    var name: String
    private var level: Int = Constant.startLevel
    private var satietyLevel: SatietyLevel = .moderate
    private var closenessLevel: ClosenessLevel = .awkward
    
    init(name: String) {
        self.name = name
    }
    
    // MARK: Mutating Level
    
    mutating func levelUp() -> PetResponse.Level {
        level += 1
        return .up(increase: 1, newLevel: level)
    }
    
    // MARK: Mutating Satiety Level
    
    mutating func eat(food: Food) -> PetResponse.Level {
        let response = satietyLevel.raise(by: food.satisfaction)
        let increase = response.increase
        switch increase {
        case 0:
            return .alreadyMax
        default:
            let newLevel = response.newLevel
            satietyLevel = newLevel
            return .up(increase: increase, newLevel: newLevel.rawValue)
        }
    }
    
    mutating func starve(by level: Int) {
        satietyLevel = satietyLevel.lower(by: level)
    }
    
    // MARK: Mutating Closeness Level
    
    mutating func becomeClose(with behavior: Behavior) -> PetResponse.Level {
        let response = closenessLevel.raise(by: behavior.satisfaction)
        let increase = response.increase
        switch increase {
        case 0:
            return .alreadyMax
        default:
            let newLevel = response.newLevel
            closenessLevel = newLevel
            return .up(increase: increase, newLevel: newLevel.rawValue)
        }
    }
}

private extension Pet {
    enum SatietyLevel: Int, LevelType {
        case starving = 1
        case hungry
        case moderate
        case full
        case stuffed
    }
}

private extension Pet {
    enum ClosenessLevel: Int, LevelType {
        case awkward = 1
        case normal
        case close
        case bestFriend
        case soulMate
    }
}
