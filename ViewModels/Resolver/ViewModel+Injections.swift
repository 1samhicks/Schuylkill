//
//  ViewModel+Injections.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/24/21.
//

import Foundation
import Resolver
import Combine
import UIKit
import SwiftUI

extension Resolver  {
    static func registerViewModels() {
        /*Resolver.register(instance: AuthenticationViewModel())
        Resolver.register(instance: MusclesListViewModel())
        Resolver.register(instance: QRViewModel())
        Resolver.register(instance: BarcodeReaderViewModel())*/
        
        register(name: .appKey) { "12345" }
        register(name: .token) { "123e4567-e89b-12d3-a456-426614174000" }
    }
}

extension Resolver.Name {
    static let appKey = Self("appKey")
    static let token = Self("token")
    
    static func initialize(_ d: String) -> Resolver.Name {
        return Self(d)
    }
    
    public func toString() -> String {
        return ""
    }
}


