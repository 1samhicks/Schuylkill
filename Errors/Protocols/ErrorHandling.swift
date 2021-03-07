//
//  ErrorHandling.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/7/21.
//

import Foundation
import SwiftyBeaver

protocol ErrorHandling {
    func getDetails() -> [String : String]
    var description : ErrorDescription { get }
    var suggestion : RecoverySuggestion { get }
    var error : Error? { get }
}

extension ErrorHandling {
    
    public func getDetails() -> [String : String] {
        var d = [String : String]()
        if let error = error {
            d[SwiftyBeaver.Naming.error] = "\(error)"
        }
        if let suggestion = suggestion {
            d[SwiftyBeaver.Naming.recovery_suggestion] = suggestion
        }
        if let description = description {
            d[SwiftyBeaver.Naming.error_description] = description
        }
        return d
    }
}
