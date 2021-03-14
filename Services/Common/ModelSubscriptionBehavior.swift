//
//  ModelSubscriptionBehavior.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Combine
import CoreMotion
import Foundation

protocol DevicePublisher: ServicePublisher {
    func send(input: DeviceEvent)

    func send(error: ApplicationError)

    func sendFinished()
}
