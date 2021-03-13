//
//  DeviceSubscriptionBehavior.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/2/21.
//

import Foundation
import CoreMotion
import Combine

protocol DeviceSubcriptionBehavior {
    
    var publisher: AnyPublisher<DeviceEvent, Error> { get }

    func send(input: CMLogItem)

    func send(error: ApplicationError)

    func sendFinished()
}
