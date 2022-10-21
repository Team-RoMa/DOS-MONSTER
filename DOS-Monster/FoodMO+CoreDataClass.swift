//
//  FoodMO+CoreDataClass.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/20.
//
//

import Foundation
import CoreData

@objc(FoodMO)
public class FoodMO: NSManagedObject {

}

extension FoodMO: EntityConvertible {
    func toEntity() -> Food {
        return Food(
            name: name ?? "",
            emoji: emoji ?? "",
            satisfaction: satisfaction
        )
    }
}
