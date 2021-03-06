//
//  DeviceError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/2/21.
//

import Foundation

public enum DeviceError: ApplicationError {
    
    case LocationError(description: ErrorDescription,suggestion: RecoverySuggestion)
    case PedometerError(innerError: Error, description : ErrorDescription,suggestion: RecoverySuggestion)
}
