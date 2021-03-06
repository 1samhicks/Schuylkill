//
//  Resolver+Injection.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import Resolver

#if !os(watchOS)
import OSLog
import Amplify
#endif

extension Resolver {
    
    public static func registerAllServices() {
        #if !os(watchOS)
        Resolver.register(instance: AmplifyAPIService())
        Resolver.register(instance: AmplifyAuthenticationService())
        Resolver.register(instance: AmplifyS3StorageService())
        #endif
        Resolver.register(instance: LocationService())
        Resolver.register(instance: AccelerometerService())
        Resolver.register(instance: MagnometerService())
    }
}

extension Resolver {
    /**
     public static func register<Service>(_ type: Service.Type = Service.self, name: Resolver.Name? = nil,
                                            factory: @escaping ResolverFactory<Service>) -> ResolverOptions<Service> {
     */
    public static func register<R : ResolverRegistrant>(instance: R,withScope scope: ResolverScope = .application)
    {
        let typeOf = type(of:instance)
        let name = Resolver.Name.initialize(instance.name)
        let key = ObjectIdentifier(R.self).hashValue
        
        Resolver.main.register(typeOf,name: Resolver.Name.initialize(instance.name),factory: { typeOf.init() } ).scope(scope)
        
        
        #if !os(watchOS)
        OSLog.registerService(resolved: typeOf, name: name, key: key, containerName: "Resolver.main")
        #endif
    }
}


