//
//  ServicePublisher.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Combine
import Foundation

protocol ServicePublisher: Publisher {
    associatedtype MyEvent = Event
    associatedtype MyError = Error

    func send(input: MyEvent)

    func send(error: MyError)

    func sendFinished()
}
