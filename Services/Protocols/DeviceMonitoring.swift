//
//  DeviceService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import CoreMotion

public protocol DeviceMonitoring {
    var motionManager: CMMotionManager { get }
    var fifoOperationQueue: OperationQueue { get }
}
