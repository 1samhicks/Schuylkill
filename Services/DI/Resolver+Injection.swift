//
//  Resolver+Injection.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import Resolver
import SwiftyBeaver
#if !os(watchOS)
import Amplify
import OSLog
#endif

public extension Resolver {
    
    internal static func registerAllServices<Service>(services : [Service]) where Service : ResolverRegistering {
        
    }
    
    static func registerAllServices() {
        #if !os(watchOS)
        Resolver.register(instance: AmplifyAPIService(), withScope: .application)
        Resolver.register(instance: AmplifyAuthenticationService(), withScope: .application)
        Resolver.register(instance: AmplifyS3StorageService(), withScope: .application)
        #endif

        Resolver.register(instance: LocationService(),withScope: .application)
        Resolver.register(instance: GyroService(),withScope: .application)
        Resolver.register(instance: MotionService(),withScope: .application)
        Resolver.register(instance: PedometerService(),withScope: .application)
        Resolver.register(instance: AccelerometerService(), withScope: .application)
        Resolver.register(instance: MagnometerService(),withScope: .application)
    }
    /**
     public static func register<Service>(_ type: Service.Type = Service.self, name: Resolver.Name? = nil,
                                            factory: @escaping ResolverFactory<Service>) -> ResolverOptions<Service> {
     */
    static func register<R: ServiceNaming>(instance: R, withScope scope: ResolverScope = .application) {
        let typeOf = type(of: instance)
        let name = Resolver.Name.initialize(instance.name)
        let key = keyName(instance: instance)

        Resolver.main.register(typeOf,
                               name: name,
                               factory: { typeOf.init() }).scope(scope)

        #if !os(watchOS)
        OSLog.registerService(resolved: typeOf as ServiceNaming.Type,
                              name: name,
                              key: key,
                              containerName: "Resolver.main")
        #else
        let message = """
        Registering service: \(typeOf.self)
        named: \(name)
        with key: \(key)
        in container: \(Resolver.main)
        """
        applicationLog.info(message)
        print(message)
        #endif
    }
    
    @inlinable
    static func keyName<R: ServiceNaming>(instance: R) -> Int {
        return ObjectIdentifier(R.self).hashValue
    }
}

