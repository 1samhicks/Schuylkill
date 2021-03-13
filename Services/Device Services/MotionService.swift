//
//  MotionService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import CoreMotion
import Combine
#if !os(watchOS)
import OSLog
#endif
public class MotionService: DeviceService {
    func publishError(error: Error) {

    }

    func publishValue(value: Event) {

    }

    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }

    var state: ServiceState?

    var dispatchSemaphore: DispatchSemaphore = DispatchSemaphore(value: 1)

    var resultSink: AnyCancellable = AnyCancellable({})

    typealias CMDeviceMotionHandler = (CMDeviceMotion?, Error?) -> Void

    required public init() {
        state = .notStarted
    }

    public func startService() {
        dispatchSemaphore.wait()
        state = .running
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates()
        resultSink = motionManager.publisher(for: \.deviceMotion).sink { _ in

        }
        dispatchSemaphore.signal()
    }

    func pauseService() {
        dispatchSemaphore.wait()
        state = .paused
        motionManager.stopDeviceMotionUpdates()
        dispatchSemaphore.signal()
    }

    func unpauseService() {
        dispatchSemaphore.wait()
        state = .running
        motionManager.startDeviceMotionUpdates()
        dispatchSemaphore.signal()
    }

    func endService() {
        dispatchSemaphore.wait()
        state = .finished
        motionManager.stopDeviceMotionUpdates()
        resultSink.cancel()
        dispatchSemaphore.signal()
    }
}
