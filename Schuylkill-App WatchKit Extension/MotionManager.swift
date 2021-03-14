//
//  MotionManager.swift
//  Schuylkill
//
//  Created by Sam Hicks on 2/4/21.
//

import CoreData
import CoreMotion
import Foundation

public struct DeviceHandler {
    typealias CMDeviceMotionHandler = (CMDeviceMotion?, Error?) -> Void
    typealias CMGyroHandler = (CMGyroData?, Error?) -> Void

    let gyroHandler: CMGyroHandler = { data, error in
        guard let rotationRate = data?.rotationRate, error == nil else {
            abort()
        }
    }

    let motionHandler: CMDeviceMotionHandler = { motion, error in
        guard let attitude = motion?.attitude, error == nil else {
            abort()
        }
    }

    let emptyAccelerometer: CMAccelerometerHandler = { _, _ in }
    var writeAccelerometerToManagedObjectContext: CMAccelerometerHandler = { data, error in
        guard let acc = data?.acceleration, error == nil else {
            var ErrorStack = String()
            Thread.callStackSymbols.forEach {
                print($0)
                ErrorStack = "\(ErrorStack)\n" + $0
            }
            abort()
        }
    }
}

public class MotionManager: NSObject {
    private var motionManager: CMMotionManager!
    private var fifoOperationQueue: OperationQueue!
    private var deviceHandlers: DeviceHandler!

    init(coreMotionManager: CMMotionManager, handledBy handlers: DeviceHandler) {
        super.init()
        fifoOperationQueue = OperationQueue()
        motionManager = coreMotionManager
        deviceHandlers = handlers
    }

    func startMotionDetection() {
        motionManager.accelerometerUpdateInterval = 0.5
        motionManager.deviceMotionUpdateInterval = 0.5
        motionManager.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xArbitraryZVertical,
                                   to: fifoOperationQueue,
                                   withHandler: deviceHandlers.motionHandler)
    }

    func startAcceleramator() {
        motionManager.startAccelerometerUpdates(to: fifoOperationQueue,
                                                withHandler: deviceHandlers.writeAccelerometerToManagedObjectContext)
    }

    func startGyro() {
        motionManager.startGyroUpdates(to: fifoOperationQueue,
                                       withHandler: deviceHandlers.gyroHandler)
    }
}
