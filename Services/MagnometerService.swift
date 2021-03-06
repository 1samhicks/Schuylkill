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
    private var _state : ServiceState?
    var dispatchSemaphore : DispatchSemaphore = DispatchSemaphore(value:1)
    var resultSink: AnyCancellable = AnyCancellable({})
    
    required public init() {
        _state = .stopped
    }
    
    public func startService() {
        
        motionManager.magnetometerUpdateInterval = 0.1
        motionManager.startMagnetometerUpdates()
        resultSink = motionManager.publisher(for:\.magnetometerData)
            .filter({ $0 != nil})
            .sink() { reading in
            self.publishValue(value: DeviceEvent.logItemEvent(reading!))
        }
    }
    
    func pauseService() {
        motionManager.stopMagnetometerUpdates()
    }
    
    func unpauseService() {
        motionManager.startMagnetometerUpdates()
    }
    
    func endService() {
        dispatchSemaphore.wait()
        motionManager.stopMagnetometerUpdates()
        resultSink.cancel()
        dispatchSemaphore.signal()
    }
    
    var serviceState: ServiceState? {
        get { return _state }
        set {
            switch newValue {
                case .canceled:
                    _state = .canceled
                    fallthrough
                case .stopped:
                    _state = .stopped
                    fallthrough
                case .finished:
                    _state = .finished
                    endService()
                case .running:
                    _state = .running
                    startService()
                    break
                case .paused:
                    _state = .paused
                    break
                case .none:
                    break
                }
    }
    }
}
