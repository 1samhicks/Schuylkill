//
//  DeviceError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/2/21.
//

import Foundation

public enum DeviceError: RawRepresentable, ApplicationError {
    typealias RawType = String

    public var rawValue: String {
                switch self {
                case .LocationError:
                    return "location_error"
                default:
                    return "pedometer_error"
                }
    }

    public init?(rawValue: String) {
        self = .LocationError(description: "", suggestion: "")
            switch rawValue {
            case "location_error":
                break
            case "pedometer_error":
                break
            default:
                break
        }
    }
    
    case GeneralDeviceError(description : ErrorDescription, suggestion : RecoverySuggestion,innerError : Error?)
    case GyroError(description: ErrorDescription, suggestion: RecoverySuggestion)
    case LocationError(description: ErrorDescription, suggestion: RecoverySuggestion)
    case PedometerError(innerError: Error, description: ErrorDescription, RecoverySuggestion)

    public init(errorDescription: ErrorDescription, recoverySuggestion: RecoverySuggestion, error: Error) {
        // Temoorary
        self = .LocationError(description: "", suggestion: "")
    }
    public var errorDescription: ErrorDescription {
        switch self {
        case .LocationError(let description, _):
                return description
        case .PedometerError(_, let description, _):
                return description
        case .GyroError(_, let description):
                return description
        case .GeneralDeviceError(let description, _, _):
            return description
        }
    }

    public var recoverySuggestion: RecoverySuggestion {
            switch self {
            case .LocationError(_, let suggestion):
                return suggestion
            case .PedometerError(_, _, let suggestion):
                return suggestion
            case .GyroError( _, let suggestion):
                return suggestion
            case .GeneralDeviceError(_,let suggestion,_):
                return suggestion
            }
    }

    public var underlyingError: Error? {
        switch self {
        case .PedometerError(let innerError, _, _):
            return innerError
        default:
            return nil
        }
    }
}
