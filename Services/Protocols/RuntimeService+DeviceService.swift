//
//  RuntimeService+DeviceService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation

extension RuntimeService where Self : DeviceService {
    var servicePublisher : some ServicePublisher {
        return DeviceServicePublisher.shared!
    }
    
    func publishValue(value: Event) {
        if(servicePublisher is DeviceServicePublisher) {
            (servicePublisher as! DeviceServicePublisher).send(input: value)
        } 
            
    }
    
    func publishError(error: Error)  {
        if(servicePublisher is DeviceServicePublisher) {
            (servicePublisher as! DeviceServicePublisher).send(error: error)
        }
    }
}

