//
//  MotionService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import CoreMotion
import Combine
import OSLog

public class MotionService : DeviceService {
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
        
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.deviceMotionUpdateInterval = 0.1
        resultSink = motionManager.publisher(for: \.deviceMotion).sink() { _ in
            
        }
    }
    
    func pauseService() {
        
    }
    
    func endService() {
        
    }
}
