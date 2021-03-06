//
//  DeviceServiceOperations.swift
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
protocol DeviceService : RuntimeService {
    typealias DeviceServiceStateTransition = (() -> ())?
    var state : ServiceState? { get set } //TODO: This shouldn't be visible to the outside world
    var dispatchSemaphore : DispatchSemaphore { get set }
    var resultSink: AnyCancellable { get set }
    func startService()
    func pauseService()
    func unpauseService()
    func endService()
    var motionManager : CMMotionManager { get }
    var fifoOperationQueue : OperationQueue { get }
    mutating func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition
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
    /*public mutating func setNewServiceState(newState: ServiceState) -> DeviceServiceStateTransition {
        switch newState {
            case .notStarted:
                return { ([weak self]) in self.state = newState }
            case .canceled:
                fallthrough
            case .stopped:
                fallthrough
            case .finished:
                return { self.endService()}
            case .running:
                return { self.startService()}
            case .paused:
                return { self.pauseService() }
    }*/
}


extension CMMotionManager  {
    static let shared = CMMotionManager()
}

extension OperationQueue {
    static let shared = OperationQueue()
}


