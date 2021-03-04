//
//  RuntimeService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import Amplify
import Combine
import CoreMotion

protocol RuntimeService : ResolverRegistrant {
    
    var servicePublisher : ServicePublisher { get }
    func onReceiveValue(value: Event)
    func onReceiveError(error : Error)
}

extension RuntimeService where Self : DeviceService {
    var servicePublisher: ServicePublisher {
        return DeviceServicePublisher.shared!
    }
}

extension RuntimeService where Self : AmplifyAuthenticationService {
    var servicePublisher : ServicePublisher {
        return AmplifyServiceModelPublisher.shared!
    }
}

extension RuntimeService where Self : AmplifyService {
    var servicePublisher : ServicePublisher {
        return AmplifyServiceModelPublisher.shared!
    }
}

extension RuntimeService where Self : AmplifyS3StorageService {
    var servicePublisher : ServicePublisher {
        return AmplifyServiceModelPublisher.shared!
    }
}

extension RuntimeService  {

    @available(iOS 13.0, *)
    internal func onReceiveCompletion(completed: ApplicationError) {
        switch completed {
        case is AuthenticationError:
            onAuthenticationError(error: ApplicationError.self as! Error)
        /*case .AuthError(let error) where AuthError.Type.self == AuthenticationError.self:
            servicePublisher.send(error: AuthenticationError.AuthError(message:error) as! ApplicationError)*/
        default:
            servicePublisher.sendFinished()
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
    func onReceiveValue(value: Event) {
            servicePublisher.send(input: value)
    }
    
    func onReceiveError(error: Error)  {
        servicePublisher.send(error: error)
    }
}

