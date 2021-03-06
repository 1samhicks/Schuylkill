//
//  InternalApplicationError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation

public enum InternalApplicationError : ApplicationError {
    case InconsistentState(ErrorDescription,RecoverySuggestion)
}
