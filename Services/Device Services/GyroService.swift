//
//  GyroService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Combine
import CoreMotion
import Foundation
public class GyroService: DeviceService {
    var lock = RecursiveLock()
    var state: ServiceState?
    var resultSink = AnyCancellable({})

    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }

    func publishValue(value: Event) {
    }

    func publishError(error: Error) {
    }

    public required init() {
    }

    public func start() {
        lock.lock()
        state = .running
        motionManager.startGyroUpdates()
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
        motionManager.stopGyroUpdates()
        lock.unlock()
    }

    func restart() {
        lock.lock()
        state = .running
        motionManager.startGyroUpdates()
        lock.unlock()
    }

    func terminate() {
        lock.lock()
        state = .finished
        motionManager.stopGyroUpdates()
        resultSink.cancel()
        lock.unlock()
    }
}
