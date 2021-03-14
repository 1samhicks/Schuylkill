//
    //  WelcomeViewController.swift
    //  Schuylkill-App
    //
    //  Created by Sam Hicks on 2/21/21.
    //

    import Combine
    import CoreLocation
    import Foundation
    import Resolver
    import SwiftUI
    import UIKit

    public class AuthenticationViewController: UIViewController, CLLocationManagerDelegate {
        var viewModel: AuthenticationViewModel!

        private var cancellable: AnyCancellable?

        override public func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .gray

            viewModel = makeViewModel()
            // viewModel.fetchCurrentAuthSession()
            viewModel.signInWithWebUI()

            cancellable = viewModel.objectWillChange.sink { [weak self] in
                self?.render()
            }
        }

        // MARK: - onboarding flow

        override public func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }

        private func render() {
        }
    }

    extension AuthenticationViewController: Resolving {
        func makeViewModel() -> AuthenticationViewModel { return AuthenticationViewModel() }
    }
