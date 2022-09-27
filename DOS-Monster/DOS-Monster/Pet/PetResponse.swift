//
//  PetResponse.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/09/27.
//

import Foundation

enum PetResponse {
    enum Level {
        case up(increase: Int, newLevel: Int)
        case alreadyMax
    }
}
