//
//  ServiceManager.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/20/21.
//

import Foundation

internal class ServiceManager<R: DeviceService, S: RuntimeService> {
    var allServices: [S]?
    var deviceServices: [R]? {
        get {
            return nil
        }
    }
    var runtimeService: [S] = []
    
}
