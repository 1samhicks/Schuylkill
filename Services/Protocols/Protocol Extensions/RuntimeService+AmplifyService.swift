//
//  RuntimeService+AmplifyService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import Amplify

extension RuntimeService where Self : AmplifyS3StorageService {
    var servicePublisher : some ServicePublisher {
        return AmplifyServiceModelPublisher.shared!
    }
}

extension RuntimeService where Self : AmplifyAuthenticationService {
    var servicePublisher : some ServicePublisher {
        return AmplifyServiceModelPublisher.shared!
    }
}

extension RuntimeService {
    @available(iOS 13.0, *)
    internal func onReceiveCompletion(completed: ApplicationError) {
        switch completed {
        case is AuthenticationError:
            onAuthenticationError(error: ApplicationError.self as! Error)
        /*case .AuthError(let error) where AuthError.Type.self == AuthenticationError.self:
            servicePublisher.send(error: AuthenticationError.AuthError(message:error) as! ApplicationError)*/
        default:
            break
        }
    }
    
    private func onAuthenticationError(error : ApplicationError) {
        let err = error as! AuthenticationError
        switch err {
            case .api(_,_): break
            case .nonUniqueResult(_,_): break
            case .configuration(_, _, _): break
            case .conflict(_): break
            case .invalidCondition(_, _, _): break
            case .decodingError(_, _): break
            case .internalOperation(_, _, _): break
            case .invalidDatabase(let string,let operror): break
            case .invalidModelName(_): break
            case .invalidOperation(_): break
            case .sync(_, _, _): break
            case .unknown(_, _, _): break
            case .AuthError(let errorString): break
            
            default: break
        }
    }
    
    @available(iOS 13.0, *)
    func publishValue(value: Event) {
        if(servicePublisher is AmplifyServiceModelPublisher) {
            (servicePublisher as! AmplifyServiceModelPublisher).send(input : value)
        }
            
    }
    
    func publishError(error: Error)  {
        if(servicePublisher is AmplifyServiceModelPublisher) {
            (servicePublisher as! AmplifyServiceModelPublisher).send(error : error)
        }
    }

}
