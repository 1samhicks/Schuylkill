//
//  DeviceSubscriptionBehavior.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/2/21.
//

import Combine
import CoreMotion
import Foundation

protocol DeviceSubcriptionBehavior {
    var publisher: AnyPublisher<DeviceEvent, Error> { get }

    func send(input: CMLogItem)

    func send(error: ApplicationError)

    func sendFinished()
}
