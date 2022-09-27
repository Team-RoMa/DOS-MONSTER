//
//  Food.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/09/27.
//

import Foundation

enum Food { // TODO: 임시 case -> 변경 예정
    case apple
    case banana
    
    var satisfaction: Int {
        switch self {
        case .apple:
            return 1
        case .banana:
            return 2
        }
    }
}
