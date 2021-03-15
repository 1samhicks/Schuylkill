import Foundation
import SwiftUI
import Amplify
import AWSS3
import AmplifyPlugins
import Resolver
import UIKit
import WatchConnectivity
import RxSwift
import RxCocoa
import CoreMotion
import SwiftyBeaver

let applicationLog = SwiftyBeaver.self

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var user = AppState()
    var userNotifications: UNUserNotificationCenterCoordinator = UNUserNotificationCenterCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        do {
           try user.configureAmplify()
           try user.configureWatchConnectivity(delegate: user.sessionDelegate)
        } catch let error {
            SwiftyBeaver.exceptionThrown(error: error)
            let alertViewController = UIAlertController(title:"App Issue",error:error,defaultActionButtonTitle:"Quit",preferredStyle:.alert,tintColor:UIColor.random)
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
