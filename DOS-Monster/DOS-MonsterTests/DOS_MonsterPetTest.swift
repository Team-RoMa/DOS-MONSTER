//
//  DOS_MonsterPetTest.swift
//  DOS-MonsterTests
//
//  Created by 김상혁 on 2022/09/27.
//

import XCTest
@testable import DOS_Monster

class DOS_MonsterPetTest: XCTestCase {
    
//    var sut: Pet!
    var sut: PetEatUsecase!
    
//    var sut2: FoodDatabaseProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
//        sut = Pet(name: "PetName")
        sut = PetEatUsecase()
        sut2 = MockFoodDatabase()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
//        sut = nil
        sut2 = nil
    }
    
    func test_pet_eatApple_upSatietyLevel1() {
//        // Given
        let food = Food.apple

        // When
        let eatResponse = sut.eat(food: food)
        let log = Logger.logSatietyLevel(of: sut.name, response: eatResponse)

        // Then
        XCTAssertEqual(log, "\(sut.name)이(가) 기뻐합니다. 포만감이 1 오릅니다. 현재 포만감: 4")
        
//        let satiety = Pet.Satiety.hungry
//
//        let feedResult = satiety.increase(by: 1)
//
//        XCTAssertEqual(feedResult.increment, 1)
//        XCTAssertEqual(feedResult.newLevel, .moderate)
//    }
}

class DOS_MonsterPetTest2: XCTestCase {
    
    var sut: FoodDatabaseProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MockFoodDatabase()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_pet_eatApple_upSatietyLevel1() {
//        // Given
//        let food = Food.apple
//
//        // When
//        let eatResponse = sut.eat(food: food)
//        let log = Logger.logSatietyLevel(of: sut.name, response: eatResponse)
//
//        // Then
//        XCTAssertEqual(log, "\(sut.name)이(가) 기뻐합니다. 포만감이 1 오릅니다. 현재 포만감: 4")
        
        let satiety = Pet.Satiety.hungry
        let 올릴레벨 = 1
        
        let feedResult = satiety.increase(by: 올릴레벨)
        
        XCTAssertEqual(feedResult.increment, 올릴레벨)
        XCTAssertEqual(feedResult.newLevel, .moderate)
    }
}


class DOS_MonsterPetTest3: XCTestCase {
    
    var sut: ExpUsecase!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ExpUsecase()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_pet_eatApple_upSatietyLevel1() {
//
        
        
        let currentLevel = 1
        let currentExp = 0

        let increaseExp = 130
        
        
        let result = sut.increase(currentLevel: currentLevel,
                                  currentExp: currentExp,
                                  increase: increaseExp)

        XCTAssertEqual(result, (1, 2, 80))
    }
}


//class DOS_MonsterPetTest: XCTestCase {
//
//    var sut: Pettable!
//
//    override func setUpWithError() throws {
//        try super.setUpWithError()
////        sut = Pet(name: "PetName")
//    }
//
//    override func tearDownWithError() throws {
//        try super.tearDownWithError()
//        sut = nil
//    }
//
//    func test_pet_eatApple_upSatietyLevel1() {
//        // Given
//        let mockFood = Food(name: "mockFood", satisfaction: 2)
//        sut = MockPet(name: "mockPet", level: Level(currentLevel: 1, currentExp: 0), satietyLevel: .full, closenessLevel: .awkward)
//
//        // When
//        let eatResponse = sut.eat(food: mockFood)
//        let log = Logger.logSatietyLevel(of: sut.name, response: eatResponse)
//
//        // Then
//        XCTAssertEqual(log, "\(sut.name)이(가) 기뻐합니다. 포만감이 \(mockFood.satisfaction) 오릅니다. 현재 포만감: \(sut.satietyLevel)")
//    }

//    func test_pet_eatBanana_upSatietyLevel2() {
//        // Given
//        let food = Food.banana
//
//        // When
//        let eatResponse = sut.eat(food: food)
//        let log = Logger.logSatietyLevel(of: sut.name, response: eatResponse)
//
//        // Then
//        XCTAssertEqual(log, "\(sut.name)이(가) 기뻐합니다. 포만감이 2 오릅니다. 현재 포만감: 5")
//    }
//
//    func test_pet_eatBanana_upSatietyToMax() {
//        // Given
////        let food = Food(name: "mockFood", satisfaction: )
//
//        // When
//        let eatResponse = sut.eat(food: food)
//        let log = Logger.logSatietyLevel(of: sut.name, response: eatResponse)
//
//        // Then
//        XCTAssertEqual(log, "\(sut.name)이(가) 기뻐합니다. 포만감이 2 오릅니다. 현재 포만감: 5")
//    }
}

