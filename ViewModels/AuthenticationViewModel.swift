//
//  AuthenticationViewModel.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/21/21.
//

import Foundation
import Resolver

struct AuthenticationViewModel {
    @LazyInjected var authenticationService : AmplifyAuthenticationService?
    var user : UserData?
    
    public init() {
        
    }
    
    init(withUser user: UserData) {
        self.user = user
    }
}
