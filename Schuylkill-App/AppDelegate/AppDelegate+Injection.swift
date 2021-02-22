//
//  AppDelegate+Injection.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/10/21.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { FirebaseAuthenticationService() }.scope(.application)
        register { AmplifyService() }.scope(.application)
        register { FirebaseService() }.scope(.application)
        register { AmplifyAuthenticationService() }.scope(.application)
    }
}
