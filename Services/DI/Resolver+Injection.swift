//
//  Resolver+Injection.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation
import Resolver

extension Resolver {
    
    public static func registerAllServices() {
        //register { FirebaseAuthenticationService() }.scope(.application)
        register { AmplifyService() }.scope(.application)
            //register { FirebaseService() }.scope(.application)
        register { AmplifyAuthenticationService() }.scope(.application)
    }
    public static func registerMyNetworkServices() {

        // Register protocols XYZFetching and XYZUpdating and create implementation object
        register { AmplifyService() }
            .implements(RuntimeService.self)

        // Register XYZNetworkService and return instance in factory closure
        //register { XYZNetworkService(session: resolve()) }

        // Register XYZSessionService and return instance in factory closure
        //register { XYZSessionService() }
    }
    
}
