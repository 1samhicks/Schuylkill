//
//  AcceleramotorService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Combine
import CoreMotion
import Foundation
/*
 Rotation rate: x,y,z
 timestamp
 */
public class AccelerometerService: DeviceService {
    var lock = RecursiveLock()
    var state: ServiceState?
    var resultSink = AnyCancellable({})

    public required init() {
    }

    // MARK: - ServiceLifecycle methods

    public func start() {
        lock.lock(); defer { lock.unlock() }
        state = .running
        resultSink = motionManager.publisher(for: \.gyroData)
            .filter({ $0 != nil })
            .sink { gyro in
                self.publishValue(value: DeviceEvent.logItemEvent(gyro!))
            }
    }

    func pause() {
        lock.lock(); defer { lock.unlock() }
        state = .paused
        motionManager.stopAccelerometerUpdates()
    }

    func restart() {
        lock.lock(); defer { lock.unlock() }
        state = .running
        motionManager.startAccelerometerUpdates()
    }

    func terminate() {
        lock.lock(); defer { lock.unlock() }
    }
}
