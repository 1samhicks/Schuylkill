//
//  PropertyWrapper.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/5/21.
//

import Foundation

@propertyWrapper
struct Storage<T: Any> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    // swiftlint:disable force_cast
    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            return query(t: defaultValue)(key) as! T
        }
        set {
            // Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    // swiftlint:enable
    func query<T: Any>(t: T) -> (_ key: String) -> Any? {
            switch t.self {
            case is String:
                return UserDefaults.standard.string(forKey:)
            case is Double:
                return UserDefaults.standard.double(forKey:)
            case is Int:
                return UserDefaults.standard.integer(forKey:)
            case is Data:
                return UserDefaults.standard.data(forKey:)
            case is [String: Any]:
                return UserDefaults.standard.dictionary(forKey:)
            case is URL:
                return UserDefaults.standard.url(forKey:)
            case is Bool:
                return UserDefaults.standard.bool(forKey:)
            default:
                return UserDefaults.standard.object(forKey:)
        }
    }
}
