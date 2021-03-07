//
//  ApplicationError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Foundation
import SwiftyBeaver

typealias ApplicationError = Error 

/// Convenience typealias to disambiguate positional parameters of DeviceErrors
public typealias ErrorDescription = String?

/// Convenience typealias to disambiguate positional parameters of DeviceErrors
public typealias RecoverySuggestion = String?





extension ApplicationError {
    internal var errorName : [String : String] {
        get {
            var rawValue : String?
            switch self {
            case is DeviceError: rawValue = (self as! DeviceError).localizedDescription; return ["Error": rawValue!]
            case is AmplifyError: rawValue = (self as! AmplifyError).localizedDescription; return ["Error": rawValue!]
            case is StorageServiceError: rawValue = (self as! StorageServiceError).localizedDescription; return ["Error": rawValue!]
            case is ApplicationRuntimeError: rawValue = (self as! ApplicationRuntimeError).localizedDescription; return ["Error": rawValue!]
            default: fatalError("The exception thrown was not recognized!")
        }
    }
    }
    
}

