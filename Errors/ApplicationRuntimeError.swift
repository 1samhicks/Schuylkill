//
//  InternalApplicationError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation

typealias ErrorDescription = String
typealias RecoverySuggestion = String

public enum ApplicationRuntimeError: ApplicationError {
    case InconsistentState(ErrorDescription, RecoverySuggestion = String.empty)
    case WatchConfigurationIssue(ErrorDescription, RecoverySuggestion = RecoverySuggestion.empty)
    case UnidentifiedError(ErrorDescription, RecoverySuggestion = RecoverySuggestion.empty)

    public init(errorDescription: ErrorDescription, recoverySuggestion: RecoverySuggestion, error: Error) {
        // self.init(errorDescription: errorDescription,recoverySuggestion: recoverySuggestion,error: error)
        self = .UnidentifiedError("This was set in the ApplicationRuntimeError", "?")
    }

    public var underlyingError: Error? {
        get {
            return nil
        }
    }

    internal var errorDescription: ErrorDescription {
        switch self {
            case .InconsistentState(let description, _):
                fallthrough
            case .WatchConfigurationIssue(let description, _):
                fallthrough
            case .UnidentifiedError(let description, _):
                return description
       }
    }

    internal var recoverySuggestion: RecoverySuggestion {
        switch self {
            case .InconsistentState(_, let suggestion):
                fallthrough
            case .WatchConfigurationIssue(_, let suggestion):
                fallthrough
            case .UnidentifiedError(_, let suggestion):
                return suggestion
       }
    }
}
