//
//  DeviceService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/13/21.
//

import Foundation

extension DeviceService {

    public var motionManager: CMMotionManager {
        CMMotionManager.shared
    }
    public var fifoOperationQueue: OperationQueue {
        OperationQueue.shared
    }
}
