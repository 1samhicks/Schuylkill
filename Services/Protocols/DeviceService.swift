//
//  DeviceServiceOperations.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import CoreMotion
import Combine
import OSLog
protocol DeviceService : RuntimeService {
    var resultSink: AnyCancellable { get set }
    func startService()
    func pauseService()
    func endService()
    var motionManager : CMMotionManager { get }
    var fifoOperationQueue : OperationQueue { get }
    
    var serviceState : ServiceState? { get }
}

extension DeviceService {
}

extension DeviceService {
    
    public var motionManager: CMMotionManager {
        CMMotionManager.shared
    }
    public var fifoOperationQueue : OperationQueue {
        OperationQueue.shared
    }
}

extension CMMotionManager  {
    static let shared = CMMotionManager()
}

extension OperationQueue {
    static let shared = OperationQueue()
}
