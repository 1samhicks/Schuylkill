//
//  GyroService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import CoreMotion
import Combine
import Amplify
public class GyroService : DeviceService {
    var dispatchSemaphore: DispatchSemaphore = DispatchSemaphore(value:1)
    
    var resultSink: AnyCancellable = AnyCancellable({})
    var serviceState: ServiceState? {
        get {
            return nil
        }
    }
    
    required public init() {
    }
    
    public func startService() {
        motionManager.startGyroUpdates()
        resultSink = motionManager.publisher(for: \.gyroData)
            .filter( { $0 != nil})
            .sink() { gyro in
            self.publishValue(value: DeviceEvent.logItemEvent(gyro!))
        }
    }
    
    func pauseService() {
         
    }
    
    func unpauseService() {
        
    }
    
    func endService() {
        motionManager.stopGyroUpdates()
    }
}
