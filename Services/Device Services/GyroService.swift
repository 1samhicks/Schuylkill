//
//  GyroService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import CoreMotion
import Combine
public class GyroService: DeviceService {
    var state: ServiceState?

    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }

    var dispatchSemaphore: DispatchSemaphore = DispatchSemaphore(value: 1)

    var resultSink: AnyCancellable = AnyCancellable({})

    required public init() {
    }

    public func startService() {
        dispatchSemaphore.wait()
        state = .running
        motionManager.startGyroUpdates()
        resultSink = motionManager.publisher(for: \.gyroData)
            .filter({ $0 != nil})
            .sink { gyro in
            self.publishValue(value: DeviceEvent.logItemEvent(gyro!))
        }
        dispatchSemaphore.signal()
    }

    func pauseService() {
        dispatchSemaphore.wait()
        state = .paused
        motionManager.stopGyroUpdates()
        dispatchSemaphore.signal()
    }

    func unpauseService() {
        dispatchSemaphore.wait()
        state = .running
        motionManager.startGyroUpdates()
        dispatchSemaphore.signal()
    }

    func endService() {
        dispatchSemaphore.wait()
        state = .finished
        motionManager.stopGyroUpdates()
        resultSink.cancel()
        dispatchSemaphore.signal()
    }
}
