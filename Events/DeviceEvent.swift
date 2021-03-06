//
//  DeviceEvent.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import CoreLocation
import CoreMotion


public enum DeviceEvent : Event {
    case logItemEvent(CMLogItem)
    case locationEvent(CLLocation)
    case headingEvent(CLHeading)
    case enteredRegion(CLRegion)
    case exitedRegion(CLRegion)
    case pedometerEvent(CMPedometerEvent)
}
