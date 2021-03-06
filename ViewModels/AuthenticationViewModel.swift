//
//  AuthenticationViewModel.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/26/21.
//

import Foundation
import Resolver
import Combine
import Amplify

class AuthenticationViewModel : ObservableObject, Identifiable, ViewModel {
    required convenience init() {
        self.init(userData: UserData.shared)
    }
    
    private var authenticationService : AmplifyAuthenticationService!
    
    @Published var userData : UserData?
    private var authCancellable : AnyCancellable?
    
    
    init(userData : UserData = UserData.shared) {
        self.userData = userData
        authenticationService = AmplifyAuthenticationService()
    }
    
    public func signInWithWebUI() {
        authCancellable = authenticationService.signInWithWebUI()
        /*let publisher = authenticationService!.resultPublisher
        
        _ = publisher.sink { (e) in
            self.userData?.isSignedIn = false
        } receiveValue: { (m) in
            self.userData?.isSignedIn = true
        }*/
    }
    
    func fetchCurrentAuthSession()  {
        authenticationService.fetchAuthSession()
    }
    
    
    
    
}
