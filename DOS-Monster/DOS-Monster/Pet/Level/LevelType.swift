//
//  Level.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/09/27.
//

import Foundation

protocol LevelType: CaseIterable, RawRepresentable where RawValue == Int { }

extension LevelType {
    var allCases: Self.AllCases {
        return Self.allCases
    }
    
    var currentIndex: Int {
//        return allCases.firstIndex { $0.rawValue == rawValue } as? Int ?? 0
        return rawValue - (allCases.first?.rawValue ?? 0)
    }
    
    var minIndex: Int {
        return allCases.startIndex as? Int ?? 0
    }
    
    var maxIndex: Int {
        return allCases.index(allCases.endIndex, offsetBy: -1) as? Int ?? 0
    }
    
    var isMax: Bool {
        return currentIndex == maxIndex
    }
    
    var isMin: Bool {
        return currentIndex == minIndex
    }
    
    var indexUpside: Int {
        return maxIndex - currentIndex
    }
    
    var indexDownside: Int {
        return currentIndex - minIndex
    }
    
    func level(of index: Int) -> Self {
        let index = allCases.index(allCases.startIndex, offsetBy: index)
        return allCases[index]
    }
    
//    func increase(by index: Int) -> Self {
//        let increment = min(currentIndex + index, indexUpside)
//        let newLevel = level(of: increment)
//        return newLevel
//    }
//
//    func decrease(by index: Int) -> Self {
//        let decrement = max(currentIndex - index, indexDownside)
//        let newLevel = level(of: decrement)
//        return newLevel
//    }
    
    func increase(by index: Int) -> (increment: Int, newLevel: Self) {
        let increment = min(currentIndex + index, indexUpside)
        let newLevel = level(of: increment)
        return (increment, newLevel)
    }

    func decrease(by index: Int) -> (decrement: Int, newLevel: Self) {
        let decrement = max(currentIndex - index, indexDownside)
        let newLevel = level(of: decrement)
        return (decrement, newLevel)
    }
}
