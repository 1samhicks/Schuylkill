//
//  StorageServiceError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation

enum StorageServiceError : ApplicationError, ErrorHandling {
    init(errorDescription: ErrorDescription, recoverySuggestion: RecoverySuggestion, error: Error) {
        self.init()
    }
    
    init() {
        self = .listFilesError("Set in init of StorageServiceError", "")
    }
    
    case uploadError(ErrorDescription,RecoverySuggestion)
    case downloadError(ErrorDescription,RecoverySuggestion)
    case listFilesError(ErrorDescription,RecoverySuggestion)
    case removeFileError(ErrorDescription,RecoverySuggestion)
    
    var underlyingError: Error? {
        get {
            return nil
        }
    }
    
    var errorDescription: ErrorDescription {
        switch self {
            case .uploadError(let description,_):
                fallthrough
            case .downloadError(let description,_):
                fallthrough
            case .listFilesError(let description,_):
                fallthrough
            case .removeFileError(let description,_):
                return description
       }
    }
    
    var recoverySuggestion : RecoverySuggestion {
        switch self {
            case .uploadError(_,let suggestion):
                fallthrough
            case .downloadError(_,let suggestion):
                fallthrough
            case .listFilesError(_,let suggestion):
                fallthrough
            case .removeFileError(_,let suggestion):
                return suggestion
       }
    }
}


