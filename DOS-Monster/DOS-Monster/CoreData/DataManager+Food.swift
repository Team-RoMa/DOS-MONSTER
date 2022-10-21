//
//  DataManager+Food.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/12.
//

import Foundation
import CoreData

extension CoreDataManager {
    func update(foodMO: FoodMO,
                name: String? = nil,
                emoji: String? = nil,
                satisfaction: Int16? = nil,
                count: Int16? = nil,
                completion: (() -> Void)? = nil) {
        mainContext.perform {
            if let name = name { // TODO: non-optional로 선언한 프로퍼티에 nil 넣어도 되는지 확인
                foodMO.name = name
            }
            
            if let emoji = emoji {
                foodMO.emoji = emoji
            }
            
            if let satisfaction = satisfaction {
                foodMO.satisfaction = satisfaction
            }
            
            if let count = count {
                foodMO.count = count
            }
            
            self.saveMainContext()
            completion?()
        }
    }
}
