//
//  DeviceError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/2/21.
//

import Foundation

public enum DeviceError: ApplicationError, ErrorHandling {
    
    case LocationError(description: ErrorDescription,suggestion: RecoverySuggestion)
    case PedometerError(innerError: Error, description : ErrorDescription,suggestion: RecoverySuggestion)
    
    var description: ErrorDescription {
        switch self {
            case .LocationError(let description,_):
                return description
            case .PedometerError(_, let description,_):
                return description
       }
    }
    
    var suggestion : RecoverySuggestion {
        switch self {
            case .LocationError(_,let suggestion):
                return suggestion
            case .PedometerError(_,_,let suggestion):
                return suggestion
       }
    }
    
    var error : Error? {
        switch self {
        case .PedometerError(let innerError,_,_):
            return innerError
        default:
            return nil
        }
    
    }
}
