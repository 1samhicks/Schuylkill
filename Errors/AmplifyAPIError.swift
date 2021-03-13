//
//  AmplifyAPIError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/10/21.
//

import Foundation
import Amplify

enum AmplifyAPIError : RawRepresentable, ApplicationError, ErrorHandling {
    
    var rawValue: String {
            switch self {
                case .unknown(_,_,_):
                    return "unknown"
                default:
                    return "query_error"
                }
    }
    
    
    init(errorDescription: ErrorDescription, recoverySuggestion: RecoverySuggestion, error: Error) {
        self.init()
    }
    
    init() {
        self = .unknown(causedBy: nil, "init", "")
    }
    
    public init?(rawValue: String) {
        self = .unknown(causedBy: nil, "failable init", "")
        switch rawValue {
            case "unknown":
                break
            case "query_editor":
                break
            default: break
        }
        
    }
    
    public typealias RawType = String
    public typealias RawValue = String
    
    case unknown(causedBy: Error? = nil,ErrorDescription, RecoverySuggestion)
    case QueryError(causedBy: Error? = nil,message: ErrorDescription, RecoverySuggestion)
    
    var underlyingError : Error? {
        switch self {
        case .unknown(let causedBy,_,_):
            fallthrough
        case .QueryError(let causedBy,_,_):
            return causedBy
        }
    }
    
    var errorDescription: ErrorDescription {
        switch self {
            case .unknown(_, let description,_):
                fallthrough
            case .QueryError(_,let description,_):
                return description
       }
    }
    
    var recoverySuggestion : RecoverySuggestion {
        switch self {
            case .unknown(_,_,let suggestion):
                return suggestion
            case .QueryError(_,_,let suggestion):
                return suggestion
       }
    }
}
