//
//  Schuylkill_AppTests.swift
//  Schuylkill-AppTests
//
//  Created by Sam Hicks on 2/5/21.

import Disk
import Resolver
import SwiftyBeaver
import XCTest
import UIKit
import WatchConnectivity
import CoreLocation

@testable import Schuylkill_App

let testLog = SwiftyBeaver.self

class SchuylkillAppTests: XCTestCase {
    override func setUpWithError() throws {
        do {
            try super.setUpWithError()
            // Put setup code here. This method is called before the invocation of each test method in the class.
            guard testLog.countDestinations() > 0 else {
                testLog.activate(forXCTest: true)
                testLog.addDestination(ConsoleDestination())
                testLog.verbose("Message: Schuylkill AppTests started")
                return
            }
        } catch let e {
            SwiftyBeaver.exceptionThrown(error: e)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.

    }

    func testResolveServices() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        Resolver.registerAllServices()
        let test1: LocationService = Resolver.resolve(LocationService.self, name: "LocationService", args: nil)
        let test2: GyroService = Resolver.resolve(GyroService.self, name: "GyroService", args: nil)
        let test3: PedometerService = Resolver.resolve(PedometerService.self, name: "PedometerService", args: nil)

        XCTAssert(test1.name == LocationService.name)
        XCTAssert(test2.name == GyroService.name)
        XCTAssert(test3.name == PedometerService.name)
    }
    
    func testStartServices() throws {
        Resolver.registerAllServices()
        let test1: LocationService = Resolver.resolve(LocationService.self, name: "LocationService", args: nil)
        let test2: GyroService = Resolver.resolve(GyroService.self, name: "GyroService", args: nil)
        let test3: PedometerService = Resolver.resolve(PedometerService.self, name: "PedometerService", args: nil)
        test1.start()
        test2.start()
        test3.start()
    }
    
    func testLocationServicePublishValue() throws {
        Resolver.registerAllServices()
        let test1: LocationService = Resolver.resolve(LocationService.self, name: "LocationService", args: nil)
        test1.start()
        test1.publishValue(value: DeviceEvent.locationEvent(try CLLocation.sample()))
    }
    
    func testLocationServicePublishError() throws {
        Resolver.registerAllServices()
        let test1: LocationService = Resolver.resolve(LocationService.self, name: "LocationService", args: nil)
        test1.start()
        test1.publishError(error: DeviceError.LocationError(description: "Testing publish error. Disregard", suggestion: "Look at the test code"))
    }

    func testAmplifySetup() throws {
        do {
            try AppState().configureAmplify()
        } catch let e {
            SwiftyBeaver.debug(e.localizedDescription)
        }
    }
    

    /*func test4() throws {

    }
    func test5() throws {

    }
    func test6() throws {

    }
    func test7() throws {

    }
    func test8() throws {

    }
    func test9() throws {

    }
    func test10() throws {

    }
    func test11() throws {

    }
    func test12() throws {

    }*/

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
