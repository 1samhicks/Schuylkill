//
//  PedometerService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Combine
import CoreMotion
import Foundation

extension CMPedometer {
    static let shared = CMPedometer()
}

public class PedometerService: DeviceService {
    var pedometer = CMPedometer.shared
    var lock = RecursiveLock()
    var state: ServiceState?
    var resultSink = AnyCancellable({})

    public required init() {
        state = .notStarted
    }

    func publishError(error: Error) {
    }

    func publishValue(value: Event) {
    }

    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }

    func start() {
        lock.lock(); defer { lock.unlock() }
        state = .running
        pedometer.startEventUpdates { (event: CMPedometerEvent?, error: Error?) in
            if let error = error {
                self.publishError(error: .PedometerError(innerError: error, description: "", ""))
            } else if let event = event {
                self.publishValue(value: .pedometerEvent(event))
            }
        }
    }

    func pause() {
        lock.lock(); defer { lock.unlock() }
        state = .paused
        pedometer.stopEventUpdates()
    }

    func restart() {
        lock.lock(); defer { lock.unlock() }
        state = .running
        pedometer.startEventUpdates { (event: CMPedometerEvent?, error: Error?) in
            if let error = error {
                self.publishError(error: .PedometerError(innerError: error, description: "", ""))
            } else if let event = event {
                self.publishValue(value: .pedometerEvent(event))
            }
        }
        
    }

    func terminate() {
        lock.lock(); defer { lock.unlock() }
        state = .finished
        pedometer.stopEventUpdates()
        resultSink.cancel()
        
    }
}
