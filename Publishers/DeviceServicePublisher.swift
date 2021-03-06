//
    //  DeviceServicePublisher.swift
    //  Schuylkill-App
    //
    //  Created by Sam Hicks on 3/2/21.
    //

    import Combine
    import CoreMotion
    import Foundation

    public class DeviceServicePublisher: ServicePublisher {
        public typealias Output = DeviceEvent
        public typealias Failure = Error
        static let shared = DeviceServicePublisher()
        private let subject = PassthroughSubject<Output, Failure>()
        init() {}

        var publisher: AnyPublisher<Output, Failure> {
            return subject.eraseToAnyPublisher()
        }

        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        }

        func send(input: DeviceEvent) {
            subject.send(input)
        }

        func send(error: DeviceError) {
            subject.send(completion: .failure(error))
        }

        func sendFinished() {
            subject.send(completion: .finished)
        }
    }
