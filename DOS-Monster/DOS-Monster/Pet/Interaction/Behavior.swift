//
//  Behavior.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/09/27.
//

import Foundation

enum Behavior { // TODO: 임시 case -> 변경 예정
    case pat
    case hug
    
    var satisfaction: Int {
        switch self {
        case .pat:
            return 1
        case .hug:
            return 2
        }
    }
}
