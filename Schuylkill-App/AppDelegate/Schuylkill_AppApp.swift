//
//  Schuylkill_AppApp.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/5/21.
//

import SwiftUI
import Amplify
import AmplifyPlugins
import Resolver

@main
struct Schuylkill_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    public init() {
        
    }
}

//
//  AppDelegate.swift
//  Schuylkill
//
//  Created by Sam Hicks on 2/2/21.
//

import Foundation
import UIKit
import WatchConnectivity

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
        @LazyInjected var authenticationService: AmplifyAuthenticationService
        
        private lazy var wcSessionChannelDelegate: WatchSessionChannelDelegate = {
            return WatchSessionChannelDelegate()
        }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        application.setupWatchConnectivity(delegate: wcSessionChannelDelegate)

        do {
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels()))
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSPinpointAnalyticsPlugin())
            Amplify.Logging.logLevel = .verbose
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            print("Could not initialize Amplify: \(error)")
        }
        
        //FirebaseApp.configure()
        registerForRemoteNotifications()
        //Messaging.messaging().delegate = self
        
        return true
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      
        //Messaging.messaging().apnsToken = deviceToken
    }
    private func registerForRemoteNotifications() {
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
}

