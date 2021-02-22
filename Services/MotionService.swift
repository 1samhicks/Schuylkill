//
//  MotionService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import CoreMotion
import Combine

public class MotionService : DeviceMonitor, DeviceService, RuntimeService {
    
    typealias CMDeviceMotionHandler = (CMDeviceMotion?, Error?) -> Void
    
    public func startService() {
        motionManager.accelerometerUpdateInterval = 0.5
        motionManager.deviceMotionUpdateInterval = 0.5
        motionManager.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xArbitraryZVertical,
                                   to: fifoOperationQueue,
                                   withHandler: motionHandler)
    }
    
    let motionHandler : CMDeviceMotionHandler = { motion, error in
        guard let attitude = motion?.attitude, error == nil else {
            abort()
        }
    }
}
