//
//  DOS_MonsterPetTest.swift
//  DOS-MonsterTests
//
//  Created by 김상혁 on 2022/09/27.
//

import XCTest
@testable import DOS_Monster

class DOS_MonsterPetTest: XCTestCase {
    
    var sut: Pet!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Pet(name: "PetName")
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_pet_eatApple_upSatietyLevel1() {
        // Given
        let food = Food.apple
        
        // When
        let eatResponse = sut.eat(food: food)
        let log = Logger.logSatietyLevel(of: sut.name, response: eatResponse)
        
        // Then
        XCTAssertEqual(log, "\(sut.name)이(가) 기뻐합니다. 포만감이 1 오릅니다. 현재 포만감: 4")
    }
}
