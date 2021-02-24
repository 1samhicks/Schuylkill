//
//  ViewModel+Injections.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/24/21.
//

import Foundation
import Resolver

extension Resolver {
    static func registerViewModels() {
        register { AuthenticationViewModel() }.scope(.shared)
        register { QRViewModel() }.scope(.shared)
        register { BarcodeReaderViewModel() }.scope(.shared)
    }
    
}
