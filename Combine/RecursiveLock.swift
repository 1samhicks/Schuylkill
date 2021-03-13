//
//  Lock.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/13/21.
//

import Foundation

#if TRACE_RESOURCES
public class RecursiveLock: NSRecursiveLock {
        override init() {
            _ = Resources.incrementTotal()
            super.init()
        }

        override func lock() {
            super.lock()
            _ = Resources.incrementTotal()
        }

        override func unlock() {
            super.unlock()
            _ = Resources.decrementTotal()
        }

        deinit {
            _ = Resources.decrementTotal()
        }
    }
#else
    typealias RecursiveLock = NSRecursiveLock
#endif

