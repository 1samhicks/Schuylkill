//
//  Lock.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/13/21.
//

import Foundation

public typealias JSONDictionary = [String: Any]
public typealias JSONArray = [JSONDictionary]
public func resolve<T>(_ jsonDictionary: [String: Any], keyPath: String) -> T? {
    var current: Any? = jsonDictionary

    keyPath.split(separator: ".").forEach { component in
        if let maybeInt = Int(component), let array = current as? Array<Any> {
            current = array[maybeInt]
        } else if let dictionary = current as? JSONDictionary {
            current = dictionary[String(component)]
        }
    }

    return current as? T
}

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

