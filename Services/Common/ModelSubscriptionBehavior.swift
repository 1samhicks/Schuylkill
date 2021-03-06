//
//  ModelSubscriptionBehavior.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Foundation
import Amplify
import Combine
import CoreMotion

@available(iOS 13.0, *)
protocol AmplifyModelChangePublisher : ServicePublisher {

    func send(input: AmplifyMutationEvent)

    func send(error: ApplicationError)

    func sendFinished()
}

protocol DevicePublisher : ServicePublisher {

    /*func send(input: CMLogItemEvent)

    func send(error: ApplicationError)

    func sendFinished()*/
}

protocol ServicePublisher : Publisher  {

    func send(input: Event)

    func send(error: Error)

    func sendFinished()
}


