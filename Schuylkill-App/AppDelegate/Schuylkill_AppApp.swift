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
import Firebase

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

extension UIApplication {
    
    var FIREBASE_INFO_PLIST : [[String:String]]? {
        guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        guard let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [[String:String]] else {
            return nil
        }
        print(plist)
        return plist
    }
    
    func setupWatchConnectivity(delegate : WatchSessionChannelDelegate) {
        assert(WCSession.isSupported(), "This sample requires Watch Connectivity support!")
        WCSession.default.delegate = delegate
        WCSession.default.activate()
        
        // Remind the setup of WatchSettings.sharedContainerID.
        //
        if WatchSettings.sharedContainerID.isEmpty {
            print("Specify a shared container ID for WatchSettings.sharedContainerID to use watch settings!")
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    @LazyInjected var authenticationService: AmplifyAuthenticationService
    private lazy var wcSessionChannelDelegate: WatchSessionChannelDelegate = {
        return WatchSessionChannelDelegate()
    }()
    
    static var API_KEY, PROJECT_ID, APPLICATION_ID : String?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //Let's get the keys from Firebase Info.plist
        if let infoPlist = application.FIREBASE_INFO_PLIST?[0] {
            AppDelegate.API_KEY = infoPlist["API_KEY"]
            AppDelegate.PROJECT_ID = infoPlist["PROJECT_ID"]
            AppDelegate.APPLICATION_ID = infoPlist["GOOGLE_APP_ID"]
        }
        
        application.setupWatchConnectivity(delegate: wcSessionChannelDelegate)

        do {
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels()))
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels())) // UNCOMMENT this line once backend is deployed
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
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict:[String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

