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
    var resultSink = AnyCancellable({})
    var serviceState: ServiceState? {
        get {
            return nil
        }
    }
    
    required public init() {
        
    }
    
    public func startService() {
        resultSink = motionManager.publisher(for: \.gyroData)
            .filter( { $0 != nil})
            .sink() { gyro in
            self.onReceiveValue(value: CMLogItemEvent.logItemEvent(gyro!))
        }
    }
    
    func pauseService() {
        
    }
    
    func endService() {
    }
    
    var servicePublisher: DeviceServicePublisher {
        DeviceServicePublisher.shared!
    }
}
