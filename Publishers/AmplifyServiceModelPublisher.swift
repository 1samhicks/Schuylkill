//
//  Publisher.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Foundation
import Combine
import Amplify

@available(iOS 13.0, *)
struct AmplifyServiceModelPublisher : AmplifyModelChangePublisher {
    func receive<S>(subscriber sub: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        //subject
    }
    typealias Output = AmplifyMutationEvent
    
    typealias Failure = AmplifyAPIError
    
    static let shared : Self? = AmplifyServiceModelPublisher()
    
    func send(input: Event) {
        subject.send(input as! AmplifyMutationEvent)
    }
    
    func send(input: AmplifyMutationEvent) {
        subject.send(input)
    }
    
    private let subject = PassthroughSubject<AmplifyMutationEvent,ApplicationError>()


    func send(error: ApplicationError) {
        subject.send(completion: .failure(error))
    }

    func sendFinished() {
        subject.send(completion: .finished)
    }
}



