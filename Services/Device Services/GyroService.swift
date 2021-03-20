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

    public required init() {
    }

    public func start() {
        lock.lock(); defer { lock.unlock() }
        state = .running
        motionManager.startGyroUpdates()
        resultSink = motionManager.publisher(for: \.gyroData)
            .filter({ $0 != nil })
            .sink { gyro in
            self.publishValue(value: DeviceEvent.logItemEvent(gyro!))
            }
    }

    func pause() {
        lock.lock(); defer { lock.unlock() }
        state = .paused
        motionManager.stopGyroUpdates()
    }

    func restart() {
        lock.lock(); defer { lock.unlock() }
        state = .running
        motionManager.startGyroUpdates()
    }

    func terminate() {
        lock.lock(); defer { lock.unlock() }
        state = .finished
        motionManager.stopGyroUpdates()
        resultSink.cancel()
    }
}
