//
//  AmplifyEvent.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Amplify
import Foundation

public enum AmplifyMutationEvent: Event {
    case mutationEvent(MutationEvent)
}

public enum AuthenticationEvent: Event {
    case started
    case mutationEvent(MutationEvent)
}
