//
//  AmplifyError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/3/21.
//

import Foundation
import Amplify

enum AmplifyAPIError : ApplicationError, ErrorHandling {
    
    
    public init?(rawValue: String) {
        fatalError("Raw value passed into AuthenticationError: \(rawValue)")
    }
    
    typealias rawType = String
    public typealias RawValue = String
    
    case unknown(causedBy: Error? = nil,ErrorDescription, RecoverySuggestion)
    case QueryError(causedBy: Error? = nil,message: ErrorDescription, RecoverySuggestion)
    
    var error : Error? {
        switch self {
        case .unknown(let causedBy,_,_):
            fallthrough
        case .QueryError(let causedBy,_,_):
            return causedBy
        }
    }
    
    var description: ErrorDescription {
        switch self {
            case .unknown(_, let description,_):
                fallthrough
            case .QueryError(_,let description,_):
                return description
       }
    }
    
    var suggestion : RecoverySuggestion {
        switch self {
            case .unknown(_,_,let suggestion):
                return suggestion
            case .QueryError(_,_,let suggestion):
                return suggestion
       }
    }
}
