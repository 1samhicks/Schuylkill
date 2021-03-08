//
//  InternalApplicationError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation

public enum ApplicationRuntimeError : ApplicationError, ErrorHandling {
    
<<<<<<< Updated upstream
    case InconsistentState(ErrorDescription,RecoverySuggestion = RecoverySuggestion.none)
    case WatchConfigurationIssue(ErrorDescription, RecoverySuggestion = RecoverySuggestion.none)
    case UnidentifiedError(ErrorDescription, RecoverySuggestion = RecoverySuggestion.none)
    
    var error: Error? {
=======
    case InconsistentState(ErrorDescription,RecoverySuggestion = RecoverySuggestion.empty)
    case WatchConfigurationIssue(ErrorDescription, RecoverySuggestion = RecoverySuggestion.empty)
    case UnidentifiedError(ErrorDescription, RecoverySuggestion = RecoverySuggestion.empty)
    
    var underlyingError: Error? {
>>>>>>> Stashed changes
        get {
            return nil
        }
    }
    
    var errorDescription: ErrorDescription {
        switch self {
            case .InconsistentState(let description,_):
                fallthrough
            case .WatchConfigurationIssue(let description,_):
                fallthrough
            case .UnidentifiedError(let description,_):
                return description
       }
    }
    
    var recoverySuggestion : RecoverySuggestion {
        switch self {
            case .InconsistentState(_,let suggestion):
                fallthrough
            case .WatchConfigurationIssue(_,let suggestion):
                fallthrough
            case .UnidentifiedError(_,let suggestion):
                return suggestion
       }
    }
}
