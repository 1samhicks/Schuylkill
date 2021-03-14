//
//  RuntimeService+AmplifyService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Amplify
import AmplifyPlugins
import Foundation

extension RuntimeService where Self: AmplifyS3StorageService {
    var servicePublisher : some ServicePublisher {
        return AmplifyServiceModelPublisher.shared!
    }
}

extension RuntimeService where Self: AmplifyAuthenticationService {
    var servicePublisher : some ServicePublisher {
        return AmplifyServiceModelPublisher.shared!
    }
}

extension RuntimeService {
    @available(iOS 13.0, *)
    internal func onReceiveCompletion(completed: ApplicationError) {
        switch completed {
        case is AuthenticationError:
            onAuthenticationError(error: completed)
        /*case .AuthError(let error) where AuthError.Type.self == AuthenticationError.self:
            servicePublisher.send(error: AuthenticationError.AuthError(message:error) as! ApplicationError)*/
        default:
            break
        }
    }

    private func onAuthenticationError(error: ApplicationError) {
    }

    @available(iOS 13.0, *)
    func publishValue(value: AmplifyMutationEvent) {
        (servicePublisher as? AmplifyServiceModelPublisher)?.send(input: value)
    }

    func publishError(error: AmplifyAPIError) {
        (servicePublisher as? AmplifyServiceModelPublisher)?.send(error: error)
    }
}
