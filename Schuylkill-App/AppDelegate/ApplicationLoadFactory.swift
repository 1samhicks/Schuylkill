//
//  ApplicationLoadFactory.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import SwiftUI

public class ApplicationLoadFactory {
    static func getFirstView<V : View>(status: UserData = UserData.shared) throws -> V {
        if(!status.isUserLoggedIn) {
            return AuthenticationView() as! V
        } else if(!status.hasOnboarded) {
            return AuthenticationView() as! V
        } else if(!status.isLocationServiceEnabled) {
            return LocationNagView() as! V
        }
        throw InternalApplicationError.InconsistentState("The user is in a state not recognized","")
    }
}
