import Foundation
import SwiftUI
import Amplify
import AWSS3
import AmplifyPlugins
import AmplifyPlugins.Swift
import Resolver
import Foundation
import UIKit
import WatchConnectivity
import RxSwift
import RxCocoa
import CoreMotion
import SwiftyBeaver

//
//  AppDelegate.swift
//  Schuylkill
//
//  Created by Sam Hicks on 2/2/21.
//

let log = SwiftyBeaver.self

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    private lazy var wcSessionChannelDelegate: WatchSessionChannelDelegate = {
        return WatchSessionChannelDelegate()
    }()

    var userNotifications: UNUserNotificationCenterCoordinator = UNUserNotificationCenterCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        Resolver.register()
        do {
            try application.setupWatchConnectivity(delegate: wcSessionChannelDelegate)
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels()))
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSAPIPlugin())
            try Amplify.add(plugin: AWSPinpointAnalyticsPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            Amplify.Logging.logLevel = .verbose
            try Amplify.configure()
            print("Initialized Amplify")
        } catch let e {
            SwiftyBeaver.exceptionThrown(error: e)
            let alertViewController = UIAlertController(title:"App Issue",error:e,defaultActionButtonTitle:"Quit",preferredStyle:.alert,tintColor:UIColor.random)
            UIApplication.shared.windows.first?.rootViewController?.addChild(alertViewController)
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
          UNUserNotificationCenter.current().delegate = userNotifications

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
