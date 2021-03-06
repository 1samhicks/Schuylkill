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
public class MotionService : DeviceService {
    func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        return nil
    }
    
    var state: ServiceState?
    
    var dispatchSemaphore: DispatchSemaphore = DispatchSemaphore(value: 1)
    
    var resultSink: AnyCancellable = AnyCancellable({})
    
    typealias CMDeviceMotionHandler = (CMDeviceMotion?, Error?) -> Void
    
    required public init() {
        
    }
    
    var serviceState : ServiceState? {
        get {
            return nil
        }
    }
    
    public func startService() {
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates()
        resultSink = motionManager.publisher(for: \.deviceMotion).sink() { _ in
            
        }
    }
    
    func pauseService() {
        
    }
    
    func unpauseService()  {
    }
    
    func endService() {
        
    }
}
