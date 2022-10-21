//
//  EntityConvertible.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/20.
//

import Foundation

protocol EntityConvertible {
    associatedtype Entity
    
    func toEntity() -> Entity
}
