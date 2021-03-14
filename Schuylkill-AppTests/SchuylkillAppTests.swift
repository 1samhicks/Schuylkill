//
//  Schuylkill_AppTests.swift
//  Schuylkill-AppTests
//
//  Created by Sam Hicks on 2/5/21.
//

import Resolver
import XCTest

@testable import Schuylkill_App

class SchuylkillAppTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        Resolver.registerAllServices()
        
        let test1 : LocationService = Resolver.resolve()
        let test2 : GyroService = Resolver.resolve()
        let test3 : PedometerService = Resolver.resolve()
        
        test1.start()
        test2.start()
        test3.start()
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
