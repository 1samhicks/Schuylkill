//
//  DeviceService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import CoreMotion
import Foundation

public protocol DeviceMonitoring {
    var motionManager: CMMotionManager { get }
    var fifoOperationQueue: OperationQueue { get }
}
