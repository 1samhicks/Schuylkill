//
//  ServicePublisher.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Combine
import Foundation

protocol ServicePublisher: Publisher {
    associatedtype T = Event
    associatedtype U = Error

    func send(input: T)

    func send(error: U)

    func sendFinished()
}
