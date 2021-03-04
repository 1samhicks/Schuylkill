//
//  Events.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Foundation
import Amplify
import CoreMotion
import CoreLocation

protocol Event {
    
}


enum DeviceEvent : Event {
    case logItemEvent(CMLogItem)
    case locationEvent(CLLocation)
    case headingEvent(CLHeading)
    case enteredRegion(CLRegion)
    case exitedRegion(CLRegion)
}

enum AmplifyMutationEvent : Event {
    case mutationEvent(MutationEvent)
}

enum AuthenticationEvent : Event {
    case started
    case mutationEvent(MutationEvent)
}




