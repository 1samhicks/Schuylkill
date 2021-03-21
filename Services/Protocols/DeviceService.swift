//
//  DeviceServiceOperations.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Combine
import CoreMotion
import Foundation
#if !os(watchOS)
import OSLog
#endif

protocol DeviceService: RuntimeService, ServiceLifecycle {
    typealias DeviceServiceStateTransition = (() -> Void)?
    var resultSink: AnyCancellable { get set }
    var motionManager: CMMotionManager { get }
    var fifoOperationQueue: OperationQueue { get }
    func buffer(value: DeviceEvent)
}

extension DeviceService {
    func buffer(value: DeviceEvent) {
    }
}

extension CMMotionManager {
    static let shared = CMMotionManager()
}

extension OperationQueue {
    static let shared = OperationQueue()
}
