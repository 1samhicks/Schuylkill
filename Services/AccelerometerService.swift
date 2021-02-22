//
//  AcceleramotorService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import CoreMotion
import Combine

public class AccelerometerService : DeviceMonitor, DeviceService, RuntimeService {
    let emptyAccelerometer : CMAccelerometerHandler = {_,_ in }
    
    var writeAccelerometerToManagedObjectContext : CMAccelerometerHandler = { data, error in
        guard let acc = data?.acceleration, error == nil else {
            var ErrorStack = String()
            Thread.callStackSymbols.forEach {
                print($0)
                ErrorStack = "\(ErrorStack)\n" + $0
            }
            abort()
        }
    }
    
    public func startService() {
        motionManager.startAccelerometerUpdates(to: fifoOperationQueue,
                                                withHandler: writeAccelerometerToManagedObjectContext)
    }
}
