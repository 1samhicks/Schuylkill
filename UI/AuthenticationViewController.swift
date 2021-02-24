
//  AuthenticationViewController.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/21/21.
//

import Foundation
import UIKit
import SwiftUI
import Amplify
import Combine
import AWSPluginsCore
import AmplifyPlugins
import Resolver

public struct AuthenticationView : UIViewControllerRepresentable {
    
    public typealias UIViewControllerType = AuthenticationViewController
    
    public func makeUIViewController(context: Context) -> AuthenticationViewController {
        return AuthenticationViewController()
    }
    
    public func updateUIViewController(_ uiViewController: AuthenticationViewController, context: Context) {
        
    }
}

public class AuthenticationViewController : UIViewController {
    @Injected var viewModel : AuthenticationViewModel
    
    var sink : AnyCancellable?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Assumes `sink` is declared as an instance variable in your view controller
        sink = Amplify.Hub
            .publisher(for: .auth)
            .sink { payload in
                switch payload.eventName {
                case HubPayload.EventName.Auth.signedIn:
                    print("User signed in")
                    // Update UI

                case HubPayload.EventName.Auth.sessionExpired:
                    print("Session expired")
                    // Re-authenticate the user

                case HubPayload.EventName.Auth.signedOut:
                    print("User signed out")
                    // Update UI

                default:
                    break
                }
            }
    }
    
    func fetchAttributes() -> AnyCancellable {
        Amplify.Auth.fetchUserAttributes()
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Fetch user attributes failed with error \(authError)")
                }
            }
            receiveValue: { attributes in
                print("User attributes - \(attributes)")
            }
    }
    
    func updateAttribute() -> AnyCancellable {
        Amplify.Auth.update(userAttribute: AuthUserAttribute(.phoneNumber, value: "+2223334444"))
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Update attribute failed with error \(authError)")
                }
            }
            receiveValue: { updateResult in
                switch updateResult.nextStep {
                case .confirmAttributeWithCode(let deliveryDetails, let info):
                    print("Confirm the attribute with details send to - \(deliveryDetails) \(String(describing: info))")
                case .done:
                    print("Update completed")
                }
            }
    }
    
    func confirmAttribute() -> AnyCancellable {
        Amplify.Auth.confirm(userAttribute: .email, confirmationCode: "390739")
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Update attribute failed with error \(authError)")
                }
            }
            receiveValue: { _ in
                print("Attribute verified")
            }
    }
    
    func resendCode() -> AnyCancellable {
        Amplify.Auth.resendConfirmationCode(for: .email)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Resend code failed with error \(authError)")
                }
            }
            receiveValue: { deliveryDetails in
                print("Resend code sent to - \(deliveryDetails)")
            }
    }
    
    func rememberDevice() -> AnyCancellable {
        Amplify.Auth.rememberDevice()
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Remember device failed with error \(authError)")
                }
            }
            receiveValue: {
                print("Remember device succeeded")
            }
    }
    func forgetDevice() -> AnyCancellable {
        Amplify.Auth.forgetDevice()
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Forget device failed with error \(authError)")
                }
            }
            receiveValue: {
                print("Forget device succeeded")
            }
    }
    
    func fetchDevices() -> AnyCancellable {
        Amplify.Auth.fetchDevices()
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Fetch devices failed with error \(authError)")
                }
            }
            receiveValue: { fetchDeviceResult in
                for device in fetchDeviceResult {
                    print(device.id)
                }
            }
    }
    
    
    func resetPassword(username: String) -> AnyCancellable {
        Amplify.Auth.resetPassword(for: username)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Reset password failed with error \(authError)")
                }
            }
            receiveValue: { resetResult in
                switch resetResult.nextStep {
                case .confirmResetPasswordWithCode(let deliveryDetails, let info):
                    print("Confirm reset password with code send to - \(deliveryDetails) \(String(describing: info))")
                case .done:
                    print("Reset completed")
                }
            }
    }
    
    func confirmResetPassword(
        username: String,
        newPassword: String,
        confirmationCode: String
    ) -> AnyCancellable {
        Amplify.Auth.confirmResetPassword(
            for: username,
            with: newPassword,
            confirmationCode: confirmationCode
        ).resultPublisher
        .sink {
            if case let .failure(authError) = $0 {
                print("Reset password failed with error \(authError)")
            }
        }
        receiveValue: {
            print("Password reset confirmed")
        }
    }
    
    func changePassword(oldPassword: String, newPassword: String) -> AnyCancellable {
        Amplify.Auth.update(oldPassword: oldPassword, to: newPassword)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Change password failed with error \(authError)")
                }
            }
            receiveValue: {
                print("Change password succeeded")
            }
    }
    
    func signOutLocally() -> AnyCancellable {
        Amplify.Auth.signOut()
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Sign out failed with error \(authError)")
                }
            }
            receiveValue: {
                print("Successfully signed out")
            }
    }
    
    func signOutGlobally() -> AnyCancellable {
        let sink = Amplify.Auth.signOut(options: .init(globalSignOut: true))
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Sign out failed with error \(authError)")
                }
            }
            receiveValue: {
                print("Successfully signed out")
            }
        return sink
    }
    
    func fetchAuthSession() {

    Amplify.Auth.fetchAuthSession { result in
        do {
            let session = try result.get()

            // Get user sub or identity id
            if let identityProvider = session as? AuthCognitoIdentityProvider {
                let usersub = try identityProvider.getUserSub().get()
                let identityId = try identityProvider.getIdentityId().get()
                print("User sub - \(usersub) and identity id \(identityId)")
            }

            // Get aws credentials
            if let awsCredentialsProvider = session as? AuthAWSCredentialsProvider {
                let credentials = try awsCredentialsProvider.getAWSCredentials().get()
                print("Access key - \(credentials.accessKey) ")
            }

            // Get cognito user pool token
            if let cognitoTokenProvider = session as? AuthCognitoTokensProvider {
                let tokens = try cognitoTokenProvider.getCognitoTokens().get()
                print("Id token - \(tokens.idToken) ")
            }

        } catch {
            print("Fetch auth session failed with error - \(error)")
        }
    }
    }
    
    func getEscapeHatch() {
        do {
            let plugin = try Amplify.Auth.getPlugin(for: "awsCognitoAuthPlugin") as! AWSCognitoAuthPlugin
            guard case let .awsMobileClient(awsmobileclient) = plugin.getEscapeHatch() else {
                print("Failed to fetch escape hatch")
                return
            }
            print("Fetched escape hatch - \(awsmobileclient)")

        } catch {
            print("Error occurred while fetching the escape hatch \(error)")
        }
    }
}

extension AuthenticationViewController : Resolving {
    func makeViewModel() -> AuthenticationViewModel { return resolver.resolve() }
}
