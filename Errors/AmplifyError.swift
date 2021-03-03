//
//  AmplifyError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/3/21.
//

import Foundation
import Amplify
enum AmplifyError : ApplicationError {
    
    
    public init?(rawValue: String) {
        fatalError("Raw value passed into AuthenticationError: \(rawValue)")
    }
    
    typealias rawType = String
    public typealias RawValue = String
    
    case unknown(ErrorDescription, RecoverySuggestion, Error? = nil)
    case QueryError(causedBy: Error)
    case QueryError(message: ErrorDescription? = nil)
}
