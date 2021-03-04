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
    var resultSink: AnyCancellable = AnyCancellable({})
    var serviceState: ServiceState? {
        get {
            return nil
        }
    }
    
    var servicePublisher: ServicePublisher {
        DeviceServicePublisher.shared!
    }
    
    required public init() {
    }
    
    public func startService() {
        motionManager.startGyroUpdates()
        resultSink = motionManager.publisher(for: \.gyroData)
            .filter( { $0 != nil})
            .sink() { gyro in
            self.onReceiveValue(value: CMLogItemEvent.logItemEvent(gyro!))
        }
    }
    
    func pauseService() {
         
    }
    
    func endService() {
        motionManager.stopGyroUpdates()
    }
    
    
    public func receive(subscriber: GyroService)  {
        
    }
}
