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
    private static var main = Bundle.main.bundleIdentifier!
    private static var watchRegistration = "watch registration"

    static let diRegistration = OSLog(subsystem: main, category: Bundle.Naming.dependencyInjection.rawValue)
    static let watchOSRegistration = OSLog(subsystem: watchRegistration, category: Bundle.Naming.watchsetup.rawValue)

    static func registerService(resolved: ServiceNaming.Type, name: Resolver.Name, key: Int, containerName: String) {
        let message = "Registering service: \(resolved.self) named: \(name) with key: \(key) in container: \(containerName)"
        print(message)
    }

    static func serviceStateChanged(resolved: ServiceNaming.Type, name: Resolver.Name, newState: ServiceState) {
        let message = "Registering service: \(resolved.self) named: \(name) has changed to State: \(newState)"
        print(message)
    }
}
