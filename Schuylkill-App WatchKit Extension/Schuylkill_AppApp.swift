//
//  Schuylkill_AppApp.swift
//  Schuylkill-App WatchKit Extension
//
//  Created by Sam Hicks on 2/5/21.
//

import SwiftUI
import CoreMotion
import WatchConnectivity
import CoreData

@main
struct Schuylkill_AppApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

public class ExtensionDelegate: NSObject, WKExtensionDelegate {
    // Hold the KVO observers as we want to keep oberving in the extension life time.
    //
    private var activationStateObservation: NSKeyValueObservation?
    private var hasContentPendingObservation: NSKeyValueObservation?
    private var motionManager : MotionManager?
    //private var locationManager : LocationManager?
    // An array to keep the background tasks.
    //
    private var wcBackgroundTasks = [WKWatchConnectivityRefreshBackgroundTask]()
    
    public func applicationDidFinishLaunching() {
        /*motionManager = MotionManager(coreMotionManager: CMMotionManager(), handledBy: DeviceHandler())
        
        locationManager = LocationManager(locationManager: CLLocationManager())
        
        motionManager!.startMotionDetection()
        motionManager!.startAcceleramator()
        motionManager!.startGyro()
        
        locationManager!.beginMonitoring()*/
    }

    public func applicationDidBecomeActive() {
        
    }

    public func applicationWillResignActive() {
        
    }

    public func applicationWillEnterForeground() {
        
    }

    public func applicationDidEnterBackground() {
        
    }
    
}
