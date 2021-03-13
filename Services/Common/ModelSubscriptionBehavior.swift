//
//  ModelSubscriptionBehavior.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Foundation
import Combine
import CoreMotion

protocol DevicePublisher: ServicePublisher {

    func send(input: DeviceEvent)

    func send(error: ApplicationError)

    func sendFinished()
}
