//
//  StorageServiceError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation

enum StorageServiceError : ApplicationError {
    case uploadError(ErrorDescription,RecoverySuggestion)
    case downloadError(ErrorDescription,RecoverySuggestion)
    case listFilesError(ErrorDescription,RecoverySuggestion)
    case removeFileError(ErrorDescription,RecoverySuggestion)
}
