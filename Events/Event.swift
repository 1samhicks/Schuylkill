//
//  Event.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import CoreLocation
import CoreMotion

public protocol Event {
}

public enum DeviceEvent: Event {
    case logItemEvent(CMLogItem)
    case locationEvent(CLLocation)
    case headingEvent(CLHeading)
    case enteredRegion(CLRegion)
    case exitedRegion(CLRegion)
    case pedometerEvent(CMPedometerEvent)
}

#if !os(watchOS)
import Amplify

public enum AmplifyMutationEvent: Event {
    case mutationEvent(MutationEvent)
}

public enum AuthenticationEvent: Event {
    case started
    case mutationEvent(MutationEvent)
}
#endif

