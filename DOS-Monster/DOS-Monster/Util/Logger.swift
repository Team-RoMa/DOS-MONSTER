//
//  Logger.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/09/27.
//

import Foundation

struct Logger {
    static func logLevel(of petName: String, response: PetResponse.Level) -> String {
        switch response {
        case .up(let increase, let newLevel):
            return "\(petName) 레벨 업(+\(increase))! 현재 레벨: \(newLevel)"
        case .alreadyMax:
            return "더 이상 레벨을 올릴 수 없습니다!"
        }
    }
    
    static func logSatietyLevel(of petName: String, response: PetResponse.Level) -> String {
        switch response {
        case .up(let increase, let newLevel):
            return "\(petName)이(가) 기뻐합니다. 포만감이 \(increase) 오릅니다. 현재 포만감: \(newLevel)"
        case .alreadyMax:
            return "더 이상 먹을 수 없습니다!"
        }
    }
    
    static func logClosenessLevel(of petName: String, response: PetResponse.Level) -> String {
        switch response {
        case .up(let increase, let newLevel):
            return "\(petName)와(과) 친해졌습니다. 친밀도가 \(increase) 오릅니다. 현재 친밀도: \(newLevel)"
        case .alreadyMax:
            return "더 이상 친해질 수 없습니다!"
        }
    }
}
