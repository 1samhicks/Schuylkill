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
    associatedtype P
    var servicePublisher: P { get }
    func publishValue(value: Event)
    func publishError(error: Error)
}
