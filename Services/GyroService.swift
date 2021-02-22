//
//  GyroService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import CoreMotion
import Combine

public class GyroService : DeviceMonitor, DeviceService, RuntimeService {
    
    typealias CMGyroHandler = (CMGyroData?, Error?) -> Void
    
    public func startService() {
        motionManager.startGyroUpdates(to: fifoOperationQueue,
                                       withHandler: gyroHandler)
    }
    
    let gyroHandler : CMGyroHandler = { data, error in
        guard let rotationRate = data?.rotationRate, error == nil else {
            abort()
        }
    }
}
