//
//  AppDelegate+Injection.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/10/21.
//

import Foundation
import Resolver

#if MOCK
extension Resolver {
    static var mock = Resolver(parent: main)
}
#endif

extension Resolver: ResolverRegistering {
    public static func register() {
        registerAllServices()
        registerViewModels()
        #if MOCK
        root = mock
        #endif
    }
}
