//
//  ApplicationErrors.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/20/21.
//


import Foundation
#if !os(watchOS)
import Amplify
typealias ApplicationError = AmplifyError
#else
/// Convenience typealias to disambiguate positional parameters of AmplifyErrors
public typealias ErrorDescription = String

/// Convenience typealias to disambiguate positional parameters of AmplifyErrors
public typealias RecoverySuggestion = String

typealias ApplicationError = Error

#endif

public extension RecoverySuggestion {
    static let empty = ""
}

public enum AuthenticationError: ApplicationError {
    public init(errorDescription: ErrorDescription, recoverySuggestion: RecoverySuggestion, error: Error) {
        self.init()
    }

    public init() {
        self = .Unknown(nil, "The setting was made in the init() of AuthenticationError.", "Review code flow through constructor" )
    }

    public init?(rawValue: String) {
        // fatalError("Raw value passed into AuthenticationError: \(rawValue)")
        self.init()
    }

    public var recoverySuggestion: RecoverySuggestion {
        switch self {
        case .configuration(_, _, let suggestion),.invalidCondition(_, _, let suggestion),.decodingError(_, let suggestion),
        .internalOperation(_, _, let suggestion),.Sync(_, _, let suggestion),.Unknown(_, _, let suggestion):
            return suggestion
        default: return RecoverySuggestion.empty
       }
    }

    public var errorDescription: ErrorDescription {
        switch self {
            case .AuthError(let description, _, _):
                return description
            case .configuration(_, let description, _):
                return description
            case .invalidCondition(_, let description, _):
                return description
            case .decodingError(let description, _):
                return description
            case .internalOperation(_, let description, _):
                return description
            case .InvalidModelName(let description):
                return description
            default: return ErrorDescription.empty
        }
    }

    public var underlyingError: Error? {
        switch self {
        /*case .AuthError(let causedBy) where (causedBy == Error):
            return causedBy*/
        case .configuration(let causedBy, _, _), .invalidCondition(let causedBy, _, _):
            return causedBy
        case .InvalidDatabase(let causedBy, _), .Sync(let causedBy, _, _), .Unknown(let causedBy, _, _):
            return causedBy
            #if !os(watchOS)
        case .api(let causedBy, _):
                return causedBy
            #endif
        default:
            return nil
        }
    }

    typealias RawType = String
    public typealias RawValue = String
    case AuthError(ErrorDescription, RecoverySuggestion, Error)
    case configuration(Error? = nil, ErrorDescription, RecoverySuggestion)
    case invalidCondition(Error? = nil, ErrorDescription, RecoverySuggestion)
    case decodingError(ErrorDescription, RecoverySuggestion)
    case internalOperation(Error? = nil, ErrorDescription, RecoverySuggestion)
    case InvalidDatabase(Error? = nil, path: String)
    case InvalidModelName(ErrorDescription)
    case InvalidOperation(causedBy: Error? = nil)
    case NonUniqueResult(ErrorDescription, count: Int)
    case Sync(Error? = nil, ErrorDescription, RecoverySuggestion)
    case Unknown(Error? = nil, ErrorDescription, RecoverySuggestion)
    #if !os(watchOS)
    case conflict(DataStoreSyncConflict)
    case api(Error? = nil, MutationEvent? = nil)
    #endif
}

enum AmplifyAPIError: RawRepresentable, ApplicationError {
    var rawValue: String {
            switch self {
                case .unknown:
                    return "unknown"
                default:
                    return "query_error"
                }
    }

    init(errorDescription: ErrorDescription, recoverySuggestion: RecoverySuggestion, error: Error) {
        self.init()
    }

    init() {
        self = .unknown(causedBy: nil, "init", "")
    }

    public init?(rawValue: String) {
        self = .unknown(causedBy: nil, "failable init", "")
        switch rawValue {
            case "unknown":
                break
            case "query_editor":
                break
            default: break
        }
    }

    public typealias RawType = String
    public typealias RawValue = String

    case unknown(causedBy: Error? = nil, ErrorDescription, RecoverySuggestion)
    case QueryError(causedBy: Error? = nil, message: ErrorDescription, RecoverySuggestion)

    var underlyingError: Error? {
        switch self {
        case .unknown(let causedBy, _, _):
            fallthrough
        case .QueryError(let causedBy, _, _):
            return causedBy
        }
    }

    var errorDescription: ErrorDescription {
        switch self {
            case .unknown(_, let description, _):
                fallthrough
            case .QueryError(_, let description, _):
                return description
       }
    }

    var recoverySuggestion: RecoverySuggestion {
            switch self {
            case .unknown(_, _, let suggestion):
                return suggestion
            case .QueryError(_, _, let suggestion):
                return suggestion
       }
    }
}

enum StorageServiceError: ApplicationError {
    init(errorDescription: ErrorDescription, recoverySuggestion: RecoverySuggestion, error: Error) {
        self.init()
    }

    init() {
        self = .listFilesError("Set in init of StorageServiceError", "")
    }

    case uploadError(ErrorDescription, RecoverySuggestion)
    case downloadError(ErrorDescription, RecoverySuggestion)
    case listFilesError(ErrorDescription, RecoverySuggestion)
    case removeFileError(ErrorDescription, RecoverySuggestion)

    var underlyingError: Error? {
        get {
            return nil
        }
    }

    var errorDescription: ErrorDescription {
        switch self {
            case .uploadError(let description, _), .downloadError(let description, _), .listFilesError(let description, _), .removeFileError(let description, _):
                return description
       }
    }

    var recoverySuggestion: RecoverySuggestion {
            switch self {
            case .uploadError(_, let suggestion):
                fallthrough
            case .downloadError(_, let suggestion):
                fallthrough
            case .listFilesError(_, let suggestion):
                fallthrough
            case .removeFileError(_, let suggestion):
                return suggestion
       }
    }
}



public enum ApplicationRuntimeError: ApplicationError {
    case InconsistentState(ErrorDescription, RecoverySuggestion = RecoverySuggestion.empty)
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

    public var errorDescription: ErrorDescription {
        switch self {
            case .InconsistentState(let description, _):
                fallthrough
            case .WatchConfigurationIssue(let description, _):
                fallthrough
            case .UnidentifiedError(let description, _):
                return description
       }
    }

    public var recoverySuggestion: RecoverySuggestion {
        switch self {
            case .InconsistentState(_,let suggestion):
                fallthrough
            case .WatchConfigurationIssue(_,let suggestion):
                fallthrough
            case .UnidentifiedError(_,let suggestion):
                return suggestion
       }
    }
}

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
