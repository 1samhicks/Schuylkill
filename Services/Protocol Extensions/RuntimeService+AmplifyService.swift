//
//  RuntimeService+AmplifyService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import Amplify

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
            onAuthenticationError(error: ApplicationError.self as! AmplifyError)
        /*case .AuthError(let error) where AuthError.Type.self == AuthenticationError.self:
            servicePublisher.send(error: AuthenticationError.AuthError(message:error) as! ApplicationError)*/
        default:
            break
        }
    }

    private func onAuthenticationError(error: ApplicationError) {
        let err = error as! AuthenticationError
        switch err {
            case .api: break
            case .nonUniqueResult: break
            case .configuration: break
            case .conflict: break
            case .invalidCondition: break
            case .decodingError: break
            case .internalOperation: break
        case .invalidDatabase: break
            case .invalidModelName: break
            case .invalidOperation: break
            case .sync: break
            case .unknown: break
        case .AuthError: break

            default: break
        }
    }

    @available(iOS 13.0, *)
    func publishValue(value: AmplifyMutationEvent) {
        (servicePublisher as? AmplifyServiceModelPublisher)?.send(input: value)
    }

    func publishError(error: AmplifyAPIError) {
        if servicePublisher is AmplifyServiceModelPublisher {
            (servicePublisher as! AmplifyServiceModelPublisher).send(error: error)
        }
    }

}
