//
//  AuthenticationError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Amplify
import Foundation

public enum AuthenticationError: ApplicationError {
    public init(errorDescription: ErrorDescription, recoverySuggestion: RecoverySuggestion, error: Error) {
        self.init()
    }

    public init() {
        self = .Unknown(nil, "The setting was made in the init() of AuthenticationError.", "Review code flow through constructor" )
    }

    public init?(rawValue: String) {
        // fatalError("Raw value passed into AuthenticationError: \(rawValue)")
        self.init()
    }

    public var recoverySuggestion: RecoverySuggestion {
        switch self {
        case .configuration(_, _, let suggestion), .invalidCondition(_, _, let suggestion), .decodingError(_, let suggestion),
        .internalOperation(_, _, let suggestion), .Sync(_, _, let suggestion), .Unknown(_, _, let suggestion):
            return suggestion
        default: return String.empty
       }
    }

    public var errorDescription: ErrorDescription {
        switch self {
            case .AuthError(let description, _, _):
                return description
            case .configuration(_, let description, _):
                return description
            case .invalidCondition(_, let description, _):
                return description
            case .decodingError(let description, _):
                return description
            case .internalOperation(_, let description, _):
                return description
            case .InvalidModelName(let description):
                return description
            default: return String.empty
        }
    }

    public var underlyingError: Error? {
        switch self {
        /*case .AuthError(let causedBy) where (causedBy == Error):
            return causedBy*/
        case .configuration(let causedBy, _, _), .invalidCondition(let causedBy, _, _), .api(let causedBy, _), .internalOperation(let causedBy, _, _),
            .InvalidDatabase(let causedBy, _), .Sync(let causedBy, _, _), .Unknown(let causedBy, _, _):
            return causedBy
        default:
            return nil
        }
    }

    typealias RawType = String
    public typealias RawValue = String
    case AuthError(ErrorDescription, RecoverySuggestion, Error)
    case api(Error? = nil, MutationEvent? = nil)
    case configuration(Error? = nil, ErrorDescription, RecoverySuggestion)
    case conflict(DataStoreSyncConflict)
    case invalidCondition(Error? = nil, ErrorDescription, RecoverySuggestion)
    case decodingError(ErrorDescription, RecoverySuggestion)
    case internalOperation(Error? = nil, ErrorDescription, RecoverySuggestion)
    case InvalidDatabase(Error? = nil, path: String)
    case InvalidModelName(ErrorDescription)
    case InvalidOperation(causedBy: Error? = nil)
    case NonUniqueResult(ErrorDescription, count: Int)
    case Sync(Error? = nil, ErrorDescription, RecoverySuggestion)
    case Unknown(Error? = nil, ErrorDescription, RecoverySuggestion)
}
