//
//  ManagedObjectConvertible.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/20.
//

import Foundation
import CoreData

protocol ManagedObjectConvertible {
    associatedtype ManagedObejct
    
    @discardableResult
    func toManagedObejct(in context: NSManagedObjectContext) -> ManagedObejct
}
