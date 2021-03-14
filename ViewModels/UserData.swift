//
//  UserData.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/21/21.
//

import Foundation

// singleton object to store user data
public class UserData: ObservableObject {
    private init() {}
    static let shared = UserData()

    @Published var status: [UserStatus]?

    public var isUserLoggedIn: Bool {
        get {
            return checkStatus(for: .loggedIn)
        }
        set {
            if var s = status {
                if newValue && !s.contains(.loggedIn) {
                    s.append(.loggedIn)
                } else if newValue {
                    // The .loggedIn status is already in the [UserStatus] array
                } else {
                    s.removeAll(where: { $0 == .loggedIn })
                }
            }
        }
    }

    public var hasOnboarded: Bool {
        return checkStatus(for: .hasOnboarded)
    }

    public var isLocationServiceEnabled: Bool {
        return checkStatus(for: .locationServicesEnabled)
    }

    enum UserStatus {
        case loggedIn
        case hasOnboarded
        case locationServicesEnabled
        case workoutCenterHasBeenSetup
    }
}

extension UserData {
    private func checkStatus(for thisStatus: UserStatus) -> Bool {
        if let status = status {
            return status.contains(thisStatus)
        }
        return false
    }
}
