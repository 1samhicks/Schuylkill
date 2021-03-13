//
//  ApplicationError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Foundation
import SwiftyBeaver
import Amplify

typealias ApplicationError = AmplifyError

/// Convenience typealias to disambiguate positional parameters of DeviceErrors
public typealias ErrorDescription = String

/// Convenience typealias to disambiguate positional parameters of DeviceErrors
public typealias RecoverySuggestion = String


extension RecoverySuggestion {
    public static let empty = ""
}

extension ErrorDescription {
    //Since RecoverySuggestion and ErrorDescription are typealiases for String,
    //public static let empty = "" *already exists.* RecoverySuggestion has it covered.
}

extension ApplicationError {
    
}

