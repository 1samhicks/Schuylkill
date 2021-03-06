//
//  PedometerService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import Combine
import CoreMotion

public class PedometerService : DeviceService {
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
        
        motionManager.magnetometerUpdateInterval = 0.1
        motionManager.startMagnetometerUpdates()
    }
    
    func pauseService() {
        
    }
    
    func unpauseService() {
        
    }
    
    func endService() {
        
    }
}
