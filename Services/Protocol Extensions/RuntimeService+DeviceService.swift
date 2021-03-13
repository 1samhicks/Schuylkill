//
//  RuntimeService+DeviceService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation

extension RuntimeService where Self: DeviceService {
    var servicePublisher : some ServicePublisher {
        return DeviceServicePublisher.shared!
    }

    func publishValue(value: DeviceEvent) {
        if servicePublisher is DeviceServicePublisher {
            (servicePublisher as! DeviceServicePublisher).send(input: value)
        }

    }

    func publishError(error: DeviceError) {
        if servicePublisher is DeviceServicePublisher {
            (servicePublisher as! DeviceServicePublisher).send(error: error)
        }
    }
}
