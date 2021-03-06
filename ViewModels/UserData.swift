//
//  UserData.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/21/21.
//

import Foundation

// singleton object to store user data
public class UserData : ObservableObject {
    private init() {}
    static let shared = UserData()

    @Published var status : [UserStatus]?
    
    var isUserLoggedIn : Bool {
        get {
            return checkStatus(for: .loggedIn)
        }
        set {
            if var s = status {
                if(newValue) {
                    s.append(.loggedIn)
                } else {
                    s.removeAll(where: { $0 == .loggedIn})
                }
            }
        }
    }
    
    var isLocationServiceEnabled : Bool {
        return checkStatus(for: .locationServicesEnabled)
    }
    
    enum UserStatus {
        case loggedIn
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
