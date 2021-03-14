//
//  AcceleramotorService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Combine
import CoreMotion
import Foundation

public class AccelerometerService: DeviceService {
    var state: ServiceState?
    var lock = RecursiveLock()
    var resultSink = AnyCancellable({})

    public required init() {
    }

    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }

    func publishValue(value: Event) {}
    func publishError(error: Error) {}

    public func start() {
        lock.lock()
        state = .running
        resultSink = motionManager.publisher(for: \.gyroData)
            .filter({ $0 != nil })
            .sink { gyro in
            self.publishValue(value: DeviceEvent.logItemEvent(gyro!))
            }
        lock.unlock()
    }

    func pause() {
        lock.lock()
        state = .paused
        motionManager.stopAccelerometerUpdates()
        lock.unlock()
    }

    func restart() {
        lock.lock()
        state = .running
        motionManager.startAccelerometerUpdates()
        lock.unlock()
    }

    func terminate() {
        lock.lock()
        lock.unlock()
    }
}
