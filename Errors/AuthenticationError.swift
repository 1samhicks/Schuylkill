//
//  AuthenticationError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Foundation
import Amplify

public enum AuthenticationError: ApplicationError {
    
    public init?(rawValue: String) {
        fatalError("Raw value passed into AuthenticationError: \(rawValue)")
    }
    
    typealias rawType = String
    public typealias RawValue = String
    case AuthError(causedBy: Error)
    case AuthError(message: ErrorDescription? = nil)
    case api(APIError, MutationEvent? = nil)
    case configuration(ErrorDescription, RecoverySuggestion, Error? = nil)
    case conflict(DataStoreSyncConflict)
    case invalidCondition(ErrorDescription, RecoverySuggestion, Error? = nil)
    case decodingError(ErrorDescription, RecoverySuggestion)
    case internalOperation(ErrorDescription, RecoverySuggestion, Error? = nil)
    case invalidDatabase(path: String, Error? = nil)
    case invalidModelName(String)
    case invalidOperation(causedBy: Error? = nil)
    case nonUniqueResult(model: String, count: Int)
    case sync(ErrorDescription, RecoverySuggestion, Error? = nil)
    case unknown(ErrorDescription, RecoverySuggestion, Error? = nil)
}
