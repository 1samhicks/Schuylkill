//
//  DeviceError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/2/21.
//

import Foundation

public enum DeviceError: ApplicationError {
    
    /// Convenience typealias to disambiguate positional parameters of DeviceErrors
    public typealias ErrorDescription = String?

    /// Convenience typealias to disambiguate positional parameters of DeviceErrors
    public typealias RecoverySuggestion = String?
    
    case LocationError(description: ErrorDescription,suggestion: RecoverySuggestion)
}
