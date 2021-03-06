//
//  Schuylkill_AppApp.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/5/21.
//

import SwiftUI
import Amplify
import AWSS3
import AmplifyPlugins
import AmplifyPlugins.Swift
import Resolver

@main
struct Schuylkill_AppApp: App {
    //var firstView = try! ApplicationLoadFactory.getFirstView()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            AuthenticationView()
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
import RxSwift
import RxCocoa
import CoreMotion
import Amplify
import AmplifyPlugins
import Resolver

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
        private lazy var wcSessionChannelDelegate: WatchSessionChannelDelegate = {
            return WatchSessionChannelDelegate()
        }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        application.setupWatchConnectivity(delegate: wcSessionChannelDelegate)
        Resolver.register()
        do {
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels()))
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSAPIPlugin())
            try Amplify.add(plugin: AWSPinpointAnalyticsPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            Amplify.Logging.logLevel = .verbose
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            print("Could not initialize Amplify: \(error)")
        }
        
        registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
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

