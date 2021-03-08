//
//  ErrorHandling.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/7/21.
//

import Foundation
import SwiftyBeaver
import Amplify

protocol ErrorHandling {
    func getDetails() -> [String : String]
    var errorDescription : ErrorDescription { get }
    var recoverySuggestion : RecoverySuggestion { get }
    var underlyingError : Error? { get }
}

extension ErrorHandling {
    
    public func getDetails() -> [String : String] {
        var d = [String : String]()
        if let underlyingError = underlyingError {
            d[SwiftyBeaver.Naming.error] = "\(underlyingError)"
        }
        if recoverySuggestion.count > 0 {
            d[SwiftyBeaver.Naming.recovery_suggestion] = recoverySuggestion
        }
        if errorDescription.count > 0 {
            d[SwiftyBeaver.Naming.error_description] = errorDescription
        }
        return d
    }
}
