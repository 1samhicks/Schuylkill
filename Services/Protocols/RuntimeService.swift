//
//  RuntimeService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Combine
import CoreMotion
import Foundation

protocol RuntimeService: ServiceNaming {
    associatedtype MyPublisher
    associatedtype MyEvent
    associatedtype MyError
    var servicePublisher: MyPublisher { get }
    func publishValue(value: MyEvent)
    func publishError(error: MyError)
}
