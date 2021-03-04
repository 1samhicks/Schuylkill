//
//  Events.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Foundation
import Amplify
import CoreMotion

protocol Event {
    
}


enum CMLogItemEvent : Event {
    case logItemEvent(CMLogItem)
}

enum AmplifyMutationEvent : Event {
    case mutationEvent(MutationEvent)
}

enum AuthenticationEvent : Event {
    case started
    case mutationEvent(MutationEvent)
}


