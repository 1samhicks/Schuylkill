    //
    //  DeviceServicePublisher.swift
    //  Schuylkill-App
    //
    //  Created by Sam Hicks on 3/2/21.
    //

    import Foundation
    import CoreMotion
    import Combine
    
    
    public class DeviceServicePublisher : ServicePublisher {
        static let shared : DeviceServicePublisher? = DeviceServicePublisher()
        
        func send(input: Event) {
            
        }
        
        private init() {
            fatalError("This init should never be called! Use the .shared instance!")
        }
        
        private let subject = PassthroughSubject<DeviceEvent,ApplicationError>()
       
        var publisher: AnyPublisher<DeviceEvent, ApplicationError> {
            return subject.eraseToAnyPublisher()
        }

        func send(input: DeviceEvent) {
            subject.send(input)
        }

        func send(error: ApplicationError) {
            subject.send(completion: .failure(error))
        }

        func sendFinished() {
            subject.send(completion: .finished)
        }
    }
