//
//  AcceleramotorService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import CoreMotion
import Combine

public class AccelerometerService : DeviceService {
    private var _state : ServiceState?
    
    
    var dispatchSemaphore: DispatchSemaphore = DispatchSemaphore(value:1)
    var resultSink = AnyCancellable({})
    
    
    required public init() {
        
    }
    
    public func startService() {
        dispatchSemaphore.wait()
        serviceState = .running
        resultSink = motionManager.publisher(for: \.gyroData)
            .filter( { $0 != nil})
            .sink() { gyro in
            self.publishValue(value: DeviceEvent.logItemEvent(gyro!))
        }
        dispatchSemaphore.signal()
    }
    
    func pauseService() {
        dispatchSemaphore.wait()
        serviceState = .paused
        motionManager.stopAccelerometerUpdates()
        dispatchSemaphore.signal()
    }
    
    func unpauseService() {
        dispatchSemaphore.wait()
        serviceState = .running
        motionManager.startAccelerometerUpdates()
        dispatchSemaphore.signal()
    }
    
    func endService() {
    }
    
    var serviceState: ServiceState? {
        get {
            _state
        }
        set {
            _state = newValue
        }
    }
}
