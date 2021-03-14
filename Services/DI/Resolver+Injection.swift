//
//  Resolver+Injection.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import Resolver

#if !os(watchOS)
import Amplify
import OSLog
#endif

public extension Resolver {
    static func registerAllServices() {
        #if !os(watchOS)
        Resolver.register(instance: AmplifyAPIService())
        Resolver.register(instance: AmplifyAuthenticationService())
        Resolver.register(instance: AmplifyS3StorageService())
        #endif

        Resolver.register(instance: LocationService())
        Resolver.register(instance: GyroService())
        Resolver.register(instance: MotionService())
        Resolver.register(instance: PedometerService())
        Resolver.register(instance: AccelerometerService())
        Resolver.register(instance: MagnometerService())
    }
    
    /**
     public static func register<Service>(_ type: Service.Type = Service.self, name: Resolver.Name? = nil,
                                            factory: @escaping ResolverFactory<Service>) -> ResolverOptions<Service> {
     */
    static func register<R: ServiceNaming>(instance: R, withScope scope: ResolverScope = .application) {
        let typeOf = type(of: instance)
        let name = Resolver.Name.initialize(instance.name)
        let key = ObjectIdentifier(R.self).hashValue

        Resolver.main.register(typeOf,
                               name: Resolver.Name.initialize(instance.name),
                               factory: { typeOf.init() }).scope(scope)

        #if !os(watchOS)
        OSLog.registerService(resolved: typeOf, name: name, key: key, containerName: "Resolver.main")
        #else
        let message = "Registering service: \(typeOf.self) named: \(name) with key: \(key) in container: \(Resolver.main)"
        print(message)
        #endif
    }
}


