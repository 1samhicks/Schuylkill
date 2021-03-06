//
//  MagnometerService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/26/21.
//

import Foundation
import CoreMotion
import Combine

public class MagnometerService : DeviceService {
    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }
    
    
    var state: ServiceState?
    
    
    var dispatchSemaphore : DispatchSemaphore = DispatchSemaphore(value:1)
    var resultSink: AnyCancellable = AnyCancellable({})
    
    required public init() {
    }
    
    public func startService() {
        dispatchSemaphore.wait()
        state = .running
        motionManager.magnetometerUpdateInterval = 0.1
        motionManager.startMagnetometerUpdates()
        resultSink = motionManager.publisher(for:\.magnetometerData)
            .filter({ $0 != nil})
            .sink() { reading in
            self.publishValue(value: DeviceEvent.logItemEvent(reading!))
        }
        dispatchSemaphore.signal()
    }
    
    func pauseService() {
        dispatchSemaphore.wait()
        state = .paused
        motionManager.stopMagnetometerUpdates()
    }
    
    func unpauseService() {
        dispatchSemaphore.wait()
        state = .running
        motionManager.startMagnetometerUpdates()
        dispatchSemaphore.signal()
    }
    
    func endService() {
        dispatchSemaphore.wait()
        state = .finished
        motionManager.stopMagnetometerUpdates()
        resultSink.cancel()
        dispatchSemaphore.signal()
    }
    
    
}
