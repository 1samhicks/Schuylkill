//
//  AuthenticationError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Foundation
import Amplify

public enum AuthenticationError: ApplicationError, ErrorHandling {
    
    public init?(rawValue: String) {
        fatalError("Raw value passed into AuthenticationError: \(rawValue)")
    }
    
    var suggestion: RecoverySuggestion {
        switch self {
        case .configuration(_,_,let suggestion):
                fallthrough
        case .invalidCondition(_,_,let suggestion):
                fallthrough
        case .decodingError(_,let suggestion):
                fallthrough
        case .internalOperation(_,_,let suggestion):
                fallthrough
        case .sync(_,_,let suggestion):
                fallthrough
        case .unknown(_,_,let suggestion):
            return suggestion
        default: return nil
       }
    }
    
    var description : ErrorDescription {
        switch self {
            case .AuthError(let description, _):
                return description
            case .configuration(_,let description, _):
                return description
            case .invalidCondition(_,let description, _):
                return description
            case .decodingError(let description, _):
                return description
            case .internalOperation(_,let description, _):
                return description
            case .invalidModelName(let description):
                return description
            default: return nil
        }
    }
    
    var error : Error? {
        switch self {
        /*case .AuthError(let causedBy) where (causedBy == Error):
            return causedBy*/
        case .configuration(let causedBy,_, _):
            fallthrough
        case .invalidCondition(let causedBy,_, _):
            return causedBy
        case .api(let causedBy,_):
            return causedBy
        case .internalOperation(let causedBy,_, _):
            return causedBy
        case .invalidDatabase(let causedBy,_):
            return causedBy
        case .sync(let causedBy,_,_):
            fallthrough
        case .unknown(let causedBy, _, _):
            return causedBy
        default:
            return nil
        }
    
    }
    
    typealias rawType = String
    public typealias RawValue = String
    case AuthError(causedBy: Error)
    case AuthError(ErrorDescription, RecoverySuggestion)
    case api(APIError, MutationEvent? = nil)
    case configuration(Error? = nil,ErrorDescription, RecoverySuggestion)
    case conflict(DataStoreSyncConflict)
    case invalidCondition(Error? = nil,ErrorDescription, RecoverySuggestion)
    case decodingError(ErrorDescription, RecoverySuggestion)
    case internalOperation(Error? = nil,ErrorDescription, RecoverySuggestion)
    case invalidDatabase(Error? = nil,path: String)
    case invalidModelName(ErrorDescription)
    case invalidOperation(causedBy: Error? = nil)
    case nonUniqueResult(ErrorDescription, count: Int)
    case sync(Error? = nil,ErrorDescription, RecoverySuggestion)
    case unknown(Error? = nil,ErrorDescription, RecoverySuggestion)
}
