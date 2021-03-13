//
//  AcceleramotorService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import CoreMotion
import Combine

public class AccelerometerService: DeviceService {

    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }

    func publishValue(value: Event) {}
    func publishError(error: Error) {}

    var state: ServiceState?

    var lock : NSLock = NSLock()
    var resultSink = AnyCancellable({})

    required public init() {

    }

    
    public func start() {
        lock.lock()
        state = .running
        resultSink = motionManager.publisher(for: \.gyroData)
            .filter({ $0 != nil})
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

    func suspend() {
        lock.lock()
        state = .running
        motionManager.startAccelerometerUpdates()
        lock.unlock()
    }

    func terminate() {
    }

}
