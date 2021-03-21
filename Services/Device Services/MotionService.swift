//
//  MotionService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//
/*
 roll, pitch, yaw
 3x3 rotation matrix
 quartnion w,x,y, z
 */
import Combine
import CoreMotion
import Foundation
#if !os(watchOS)
import OSLog
#endif
public class MotionService: DeviceService {
    var lock = RecursiveLock()
    var state: ServiceState?
    var resultSink = AnyCancellable({})

    typealias CMDeviceMotionHandler = (CMDeviceMotion?, Error?) -> Void

    public required init() {
        state = .notStarted
    }

    public func start() {
            lock.lock(); defer {lock.unlock() }
            state = .running
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates()
            resultSink = motionManager.publisher(for: \.deviceMotion).sink { _ in
        }
    }

    func pause() {
            lock.lock(); defer {lock.unlock() }
            state = .paused
            motionManager.stopDeviceMotionUpdates()
    }

    func restart() {
            lock.lock(); defer {lock.unlock() }
            state = .running
            motionManager.startDeviceMotionUpdates()
    }

    func terminate() {
            lock.lock(); defer {lock.unlock() }
            state = .finished
            motionManager.stopDeviceMotionUpdates()
            resultSink.cancel()
    }
}
