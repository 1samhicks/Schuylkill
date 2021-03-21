//
//  Publisher.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Amplify
import Combine
import Foundation

@available(iOS 13.0, *)
struct AmplifyServiceModelPublisher: AmplifyModelChangePublisher {
    func receive<S>(subscriber sub: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        // subject
    }
    typealias Output = AmplifyMutationEvent
    typealias Failure = AmplifyAPIError

    private let subject = PassthroughSubject<AmplifyMutationEvent, AmplifyAPIError>()
    static let shared: Self? = AmplifyServiceModelPublisher()

    func send(input: AmplifyMutationEvent) {
        subject.send(input)
    }

    func send(error: AmplifyAPIError) {
        subject.send(completion:
                        .failure(error)
        )
    }

    func sendFinished() {
        subject.send(completion: .finished)
    }
}
