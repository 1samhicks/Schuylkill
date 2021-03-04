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
    
    var resultSink: AnyCancellable = AnyCancellable({})
    
    required public init() {
        
    }
    
    public func startService() {
        
        motionManager.magnetometerUpdateInterval = 0.1
        motionManager.startMagnetometerUpdates()
        resultSink = motionManager.publisher(for:\.magnetometerData)
            .filter({ $0 != nil})
            .sink() { reading in
            self.onReceiveValue(value: CMLogItemEvent.logItemEvent(reading!))
        }
    }
    
    func pauseService() {
         
    }
    
    func endService() {
        motionManager.stopMagnetometerUpdates()
        resultSink.cancel()
    }
    
    var serviceState: ServiceState? {
        get {
            return nil
        }
    }
}
