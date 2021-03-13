//
//  PedometerService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import Combine
import CoreMotion


extension CMPedometer {
    static let shared = CMPedometer()
}

public class PedometerService : DeviceService {
    func publishError(error: Error) {
        
    }
    
    func publishValue(value: Event) {
        
    }
    
    var pedometer = CMPedometer.shared
    
    
    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }
    
    
    var state: ServiceState?
    
    var dispatchSemaphore: DispatchSemaphore = DispatchSemaphore(value:1)
    var resultSink: AnyCancellable = AnyCancellable({})
    
    required public init() {
        state = .notStarted
    }
    
    func startService() {
        dispatchSemaphore.wait()
        state = .running
        pedometer.startEventUpdates { (event : CMPedometerEvent?, error : Error?) in
            if let error = error {
                self.publishError(error:.PedometerError(innerError: error, description: "", ""))
            }
            else if let event = event {
                self.publishValue(value:.pedometerEvent(event))
            }
        }
        dispatchSemaphore.signal()
    }
    
    func pauseService() {
        dispatchSemaphore.wait()
        state = .paused
        pedometer.stopEventUpdates()
        dispatchSemaphore.signal()
    }
    
    func unpauseService() {
        dispatchSemaphore.wait()
        state = .running
        pedometer.startEventUpdates { (event : CMPedometerEvent?, error : Error?) in
            if let error = error {
                self.publishError(error:.PedometerError(innerError: error,description: "",""))
            }
            else if let event = event {
                self.publishValue(value:.pedometerEvent(event))
            }
        }
        dispatchSemaphore.signal()
    }
    
    func endService() {
        dispatchSemaphore.wait()
        state = .finished
        pedometer.stopEventUpdates()
        resultSink.cancel()
        dispatchSemaphore.signal()
    }
}
