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
        return allCases.firstIndex { $0.rawValue == rawValue } as? Int ?? 0
    }
    
    var minIndex: Int {
        return allCases.startIndex as? Int ?? 0
    }
    
    var maxIndex: Int {
        return allCases.index(allCases.endIndex, offsetBy: -1) as? Int ?? 0
    }
    
    var remainingUpside: Int {
        return maxIndex - currentIndex
    }
    
    func level(of index: Int) -> Self {
        let index = allCases.index(allCases.startIndex, offsetBy: index)
        return allCases[index]
    }
    
    func raise(by index: Int) -> (newLevel: Self, increase: Int) {
        let increase = min(index, remainingUpside)
        let newLevel = level(of: currentIndex + increase)
        return (newLevel, increase)
    }
    
    func lower(by index: Int) -> Self {
        let downside = min(currentIndex, index)
        let newLevel = level(of: currentIndex - downside)
        return newLevel
    }
}
