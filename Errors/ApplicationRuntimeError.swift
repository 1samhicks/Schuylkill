//
//  InternalApplicationError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation

public enum ApplicationRuntimeError : ApplicationError {
    case InconsistentState(ErrorDescription,RecoverySuggestion)
    case WatchConfigurationIssue(ErrorDescription, RecoverySuggestion = RecoverySuggestion.none)
}
