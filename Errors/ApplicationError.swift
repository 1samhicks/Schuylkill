//
//  ApplicationError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Foundation

typealias ApplicationError = Error 

/// Convenience typealias to disambiguate positional parameters of DeviceErrors
public typealias ErrorDescription = String?

/// Convenience typealias to disambiguate positional parameters of DeviceErrors
public typealias RecoverySuggestion = String?

extension RecoverySuggestion {
    static let none = "Recovery suggestion yet to be determined"
}

