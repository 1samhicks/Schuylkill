//
//  RuntimeService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import Combine
import CoreMotion

protocol RuntimeService : ResolverRegistrant {
    associatedtype publisher
    var servicePublisher : publisher { get }
    func publishValue(value: Event)
    func publishError(error : Error)
}

