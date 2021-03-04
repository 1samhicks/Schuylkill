//
//  File.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/2/21.
//

import Foundation
import OSLog
import Resolver

extension OSLog {
    private static var logger = Logger()
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let diRegistration = OSLog(subsystem: subsystem, category: "dependency_injection_registration")
    
    static func registerService(resolved: ResolverRegistrant.Type,name : Resolver.Name, key : Int, containerName: String) {
        let message = "Registering service: \(resolved.self) named: \(name) with key: \(key) in container: \(containerName)"
        print(message)
    }
    
    static func serviceStateChanged(resolved: ResolverRegistrant.Type,name : Resolver.Name, newState : ServiceState) {
        let message = "Registering service: \(resolved.self) named: \(name) has changed to State: \(newState)"
        print(message)
    }
}
