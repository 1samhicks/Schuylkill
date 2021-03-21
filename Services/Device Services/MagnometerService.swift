//
//  MagnometerService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/26/21.
//

import Combine
import CoreMotion
import Foundation

public class MagnometerService: DeviceService {
    var state: ServiceState?
    var lock = RecursiveLock()

    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }

    var resultSink = AnyCancellable({})

    public required init() {
    }

    // MARK: - ServiceLifecycle methods
    public func start() {
        lock.lock(); defer { lock.unlock() }
        state = .running
        motionManager.magnetometerUpdateInterval = 0.1
        motionManager.startMagnetometerUpdates()
        resultSink = motionManager.publisher(for: \.magnetometerData)
            .filter({ $0 != nil })
            .sink { reading in
            self.publishValue(value: DeviceEvent.logItemEvent(reading!))
            }
    }

    func pause() {
        lock.lock(); defer { lock.unlock() }
        state = .paused
        motionManager.stopMagnetometerUpdates()
    }

    func restart() {
        lock.lock(); defer { lock.unlock() }
        state = .running
        motionManager.startMagnetometerUpdates()
    }

    func terminate() {
        lock.lock(); defer { lock.unlock() }
        state = .finished
        motionManager.stopMagnetometerUpdates()
        resultSink.cancel()
    }
}
