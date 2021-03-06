//
//  AmplifyModelChangePublisher.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import Amplify

@available(iOS 13.0, *)
protocol AmplifyModelChangePublisher : ServicePublisher {

    func send(input: AmplifyMutationEvent)

    func send(error: ApplicationError)

    func sendFinished()
}
