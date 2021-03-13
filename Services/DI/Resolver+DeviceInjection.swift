//
//  Resolver+DeviceInjection.swift
//  Schuylkill-App WatchKit Extension
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerAllDeviceServices() {
        Resolver.register(instance: LocationService())
        Resolver.register(instance: AccelerometerService())
        Resolver.register(instance: MagnometerService())
    }
}
