//
//  DataManager.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/12.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() { }
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveMainContext() {
        mainContext.perform {
            if self.mainContext.hasChanges {
                do {
                    try self.mainContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }
}

//class FoodRepository {
////    private let mainContext = DataManager.shared
//
//    func createFood(name: String, emoji: String, satisfaction: Int, completion: (() -> Void)? = nil) {
//        mainContext.perform { // weak self?
//            let newFood = FoodEntity(context: self.mainContext)
//            newFood.setUp(name: name, emoji: emoji, satisfaction: Int16(satisfaction))
//
//            self.saveMainContext()
//            completion?()
//        }
//    }
//
//    func fetchFoodEntities() -> [FoodEntity] {
//        var list: [FoodEntity] = []
//
//        mainContext.performAndWait {
//            // 데이터를 가져오기 위해 PersonEntity에 자동으로 구현되어있는 `fetchRequest`메소드를 사용
//            let request: NSFetchRequest<FoodEntity> = FoodEntity.fetchRequest()
//
//            let sortBySatisfaction = NSSortDescriptor(key: #keyPath(FoodEntity.satisfaction), ascending: true)
//            request.sortDescriptors = [sortBySatisfaction]
//
//            do {
//                list = try mainContext.fetch(request)
//            } catch {
//                print(error)
//            }
//        }
//        return list
//    }
//
//    func updateFood(entity: FoodEntity, name: String, emoji: String, satisfaction: Int, completion: (() -> Void)? = nil) {
//        mainContext.perform {
//            entity.setUp(name: name, emoji: emoji, satisfaction: Int16(satisfaction))
//            self.saveMainContext()
//            completion?()
//        }
//    }
//
//    func delete(entity: FoodEntity, completion: (() -> Void)? = nil) {
//        mainContext.perform {
//            self.mainContext.delete(entity)
//            self.saveMainContext()
//            completion?()
//        }
//    }
//
//}

extension CoreDataManager {
    func fetch<MO: NSManagedObject>(request: NSFetchRequest<MO>) -> [MO] {
        var result: [MO] = []
        
        mainContext.performAndWait {
            // 데이터를 가져오기 위해 PersonEntity에 자동으로 구현되어있는 `fetchRequest`메소드를 사용
//            let request: NSFetchRequest<MO> = Entity.fetchRequest()
//
//            let sortBySatisfaction = NSSortDescriptor(key: #keyPath(Entity.satisfaction), ascending: true)
//            request.sortDescriptors = [sortBySatisfaction]
            do {
                result = try mainContext.fetch(request)
            } catch {
                print(error) //FIXME: Error Handling
            }
        }
        return result
    }
    
    func create<Entity: ManagedObjectConvertible>(from entity: Entity, completion: (() -> Void)? = nil) {
        mainContext.perform { // weak self?
            entity.toManagedObejct(in: self.mainContext)
            self.saveMainContext()
            completion?()
        }
    }
    
    func delete<MO: NSManagedObject>(object: MO, completion: (() -> Void)? = nil) {
        mainContext.perform {
            self.mainContext.delete(object)
            self.saveMainContext()
            completion?()
        }
    }
}
