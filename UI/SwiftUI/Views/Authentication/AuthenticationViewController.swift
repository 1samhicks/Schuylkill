    //
    //  WelcomeViewController.swift
    //  Schuylkill-App
    //
    //  Created by Sam Hicks on 2/21/21.
    //

    import Foundation
    import UIKit
    import CoreLocation
    import SwiftUI
    import Resolver
    import Combine

    public class AuthenticationViewController : UIViewController, CLLocationManagerDelegate {
        var viewModel : AuthenticationViewModel!
        
        private var cancellable: AnyCancellable?
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .gray
            
            viewModel = makeViewModel()
            //viewModel.fetchCurrentAuthSession()
            viewModel.signInWithWebUI()
            
            cancellable = viewModel.objectWillChange.sink { [weak self] in
                self?.render()
            }
        }
        
        // MARK: - onboarding flow
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
        }
        
        private func render() {
        }
    }

    extension AuthenticationViewController : Resolving {
        func makeViewModel() -> AuthenticationViewModel { return AuthenticationViewModel() }
    }
