//
//  AmplifyAuthenticationService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/21/21.
//

import Foundation
import Amplify
import Combine
import AWSPluginsCore
import AmplifyPlugins
import OSLog

public class AmplifyAuthenticationService : RuntimeService {
    
    var sink : AnyCancellable?
    
    public required init() {
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
    
    
    func signUp(username: String, password: String, email: String) -> AnyCancellable {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        let sink = Amplify.Auth.signUp(username: username, password: password, options: options)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("An error occurred while registering a user \(authError)")
                }
            }
            receiveValue: { signUpResult in
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }

            }
        return sink
    }
    
    func confirmSignUp(for username: String, with confirmationCode: String) -> AnyCancellable {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("An error occurred while confirming sign up \(authError)")
                }
            }
            receiveValue: { _ in
                print("Confirm signUp succeeded")
            }
    }
    
    func signUp(username: String, password: String, email: String, phonenumber: String) -> AnyCancellable {
        let userAttributes = [AuthUserAttribute(.email, value: email), AuthUserAttribute(.phoneNumber, value: phonenumber)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        let sink = Amplify.Auth.signUp(username: username, password: password, options: options)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("An error occurred while registering a user \(authError)")
                }
            }
            receiveValue: { signUpResult in
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
            }
        return sink
    }
    
    func signIn(username: String, password: String) -> AnyCancellable {
        Amplify.Auth.signIn(username: username, password: password)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Sign in failed \(authError)")
                }
            }
            receiveValue: { _ in
                print("Sign in succeeded")
            }
    }
    
    func confirmSignIn() -> AnyCancellable {
        Amplify.Auth.confirmSignIn(challengeResponse: "<confirmation code received via SMS>")
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Confirm sign in failed \(authError)")
                }
            }
            receiveValue: { signInResult in
                print("Confirm sign in succeeded. Next step: \(signInResult.nextStep)")
            }
    }
    
    func signInWithWebUI() -> AnyCancellable {
        Amplify.Auth.signInWithWebUI(presentationAnchor: UIApplication.shared.windows.first!)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    self.onReceiveCompletion(completed: AuthenticationError.AuthError(causedBy:authError))
                }
            }
            receiveValue: { val in
                self.onReceiveValue(value:AuthenticationEvent.started)
            }
    }
    
    func socialSignInWithWebUI() -> AnyCancellable {
        Amplify.Auth.signInWithWebUI(for: .facebook, presentationAnchor: UIApplication.shared.windows.first!)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Sign in failed \(authError)")
                }
            }
            receiveValue: { _ in
                print("Sign in succeeded")
            }
    }
    
    // signin with Cognito web user interface
    public func signIn() {

        _ = Amplify.Auth.signInWithWebUI(presentationAnchor: UIApplication.shared.windows.first!) { result in
            switch result {
            case .success(_):
                print("Sign in succeeded")
            case .failure(let error):
                print("Sign in failed \(error)")
            }
        }
    }

    // signout
    public func signOut() {

        _ = Amplify.Auth.signOut() { (result) in
            switch result {
            case .success:
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }

    // change our internal state, this triggers an UI update on the main thread
    func updateUserData(withSignInStatus status : Bool) {
        DispatchQueue.main.async() {
            let userData : UserData = .shared
            userData.isSignedIn = status
        }
    }
    
    func signIn(username: String, password: String) {
        Amplify.Auth.signIn(username: username, password: password) { result in
            do {
                    let signinResult = try result.get()
                    switch signinResult.nextStep {
                    case .confirmSignInWithSMSMFACode(let deliveryDetails, let info):
                        print("SMS code send to \(deliveryDetails.destination)")
                        print("Additional info \(String(describing: info))")

                        // Prompt the user to enter the SMSMFA code they received
                        // Then invoke `confirmSignIn` api with the code

                    case .confirmSignInWithCustomChallenge(let info):
                        print("Custom challenge, additional info \(String(describing: info))")

                        // Prompt the user to enter custom challenge answer
                        // Then invoke `confirmSignIn` api with the answer

                    case .confirmSignInWithNewPassword(let info):
                        print("New password additional info \(String(describing: info))")

                        // Prompt the user to enter a new password
                        // Then invoke `confirmSignIn` api with new password

                    case .resetPassword(let info):
                        print("Reset password additional info \(String(describing: info))")

                        // User needs to reset their password.
                        // Invoke `resetPassword` api to start the reset password
                        // flow, and once reset password flow completes, invoke
                        // `signIn` api to trigger signin flow again.

                    case .confirmSignUp(let info):
                        print("Confirm signup additional info \(String(describing: info))")

                        // User was not confirmed during the signup process.
                        // Invoke `confirmSignUp` api to confirm the user if
                        // they have the confirmation code. If they do not have the
                        // confirmation code, invoke `resendSignUpCode` to send the
                        // code again.
                        // After the user is confirmed, invoke the `signIn` api again.
                    case .done:

                        // Use has successfully signed in to the app
                        print("Signin complete")
                    }
                } catch {
                    print ("Sign in failed \(error)")
                }
        }
    }
    
    func confirmSignIn(newPasswordFromUser: String) -> AnyCancellable {
        Amplify.Auth.confirmSignIn(challengeResponse: newPasswordFromUser)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Confirm sign in failed \(authError)")
                }
            }
            receiveValue: { signInResult in
                if signInResult.isSignedIn {
                    print("Confirm sign in succeeded. The user is signed in.")
                } else {
                    print("Confirm sign in succeeded.")
                    print("Next step: \(signInResult.nextStep)")
                    // Switch on the next step to take appropriate actions.
                    // If `signInResult.isSignedIn` is true, the next step
                    // is 'done', and the user is now signed in.
                }
            }
    }
    
    func resetPassword(username: String) -> AnyCancellable {
        Amplify.Auth.resetPassword(for: username)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Reset password  failed \(authError)")
                }
            }
            receiveValue: { resetPasswordResult in
                print("Reset password succeeded.")
                print("Next step: \(resetPasswordResult.nextStep)")
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
    
    func fetchCurrentAuthSession() {
        _ = Amplify.Auth.fetchAuthSession { result in
            switch result {
            case .success(let session):
                print("Is user signed in - \(session.isSignedIn)")
            case .failure(let error):
                print("Fetch session failed with error \(error)")
            }
        }
    }
    
    

    
}



