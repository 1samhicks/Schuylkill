//
//  AmplifyModelChangePublisher.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Amplify
import Foundation

@available(iOS 13.0, *)
protocol AmplifyModelChangePublisher: ServicePublisher
    where MyEvent == AmplifyMutationEvent, MyError == AmplifyAPIError {
    func send(input: MyEvent)

    func send(error: MyError)

    func sendFinished()
}
