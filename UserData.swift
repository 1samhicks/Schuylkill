//
//  UserData.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/21/21.
//

import Foundation

// singleton object to store user data
class UserData : ObservableObject {
    private init() {}
    static let shared = UserData()

    @Published var isSignedIn : Bool = false
}
