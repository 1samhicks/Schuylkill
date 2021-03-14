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

    func publishValue(value: Event) {
    }

    func publishError(error: Error) {
    }

    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }

    var resultSink = AnyCancellable({})

    public required init() {
    }

    public func start() {
        lock.lock()
        state = .running
        motionManager.magnetometerUpdateInterval = 0.1
        motionManager.startMagnetometerUpdates()
        resultSink = motionManager.publisher(for: \.magnetometerData)
            .filter({ $0 != nil })
            .sink { reading in
            self.publishValue(value: DeviceEvent.logItemEvent(reading!))
            }
        lock.unlock()
    }

    func pause() {
        lock.lock()
        state = .paused
        motionManager.stopMagnetometerUpdates()
        lock.unlock()
    }

    func restart() {
        lock.lock()
        state = .running
        motionManager.startMagnetometerUpdates()
        lock.unlock()
    }

    func terminate() {
        lock.lock()
        state = .finished
        motionManager.stopMagnetometerUpdates()
        resultSink.cancel()
        lock.unlock()
    }
}
