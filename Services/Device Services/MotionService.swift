//
//  MotionService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Combine
import CoreMotion
import Foundation
#if !os(watchOS)
import OSLog
#endif
public class MotionService: DeviceService {
    var lock = RecursiveLock()
    var state: ServiceState?
    var resultSink = AnyCancellable({})

    func publishError(error: Error) {
    }

    func publishValue(value: Event) {
    }

    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }

    typealias CMDeviceMotionHandler = (CMDeviceMotion?, Error?) -> Void

    public required init() {
        state = .notStarted
    }

    public func start() {
        lock.lock()
        state = .running
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates()
        resultSink = motionManager.publisher(for: \.deviceMotion).sink { _ in
        }
        lock.unlock()
    }

    func pause() {
        lock.lock()
        state = .paused
        motionManager.stopDeviceMotionUpdates()
        lock.unlock()
    }

    func restart() {
        lock.lock()
        state = .running
        motionManager.startDeviceMotionUpdates()
        lock.unlock()
    }

    func terminate() {
        lock.lock()
        state = .finished
        motionManager.stopDeviceMotionUpdates()
        resultSink.cancel()
        lock.unlock()
    }
}
