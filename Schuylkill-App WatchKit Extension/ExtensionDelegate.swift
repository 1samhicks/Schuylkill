//
//  Schuylkill_AppApp.swift
//  Schuylkill-App WatchKit Extension
//
//  Created by Sam Hicks on 2/5/21.
//
import CoreMotion
import Foundation
import Resolver
import SwiftUI
import WatchConnectivity
import WatchKit

public class ExtensionDelegate: NSObject, WKExtensionDelegate {
    private lazy weak var sessionDelegate: SessionDelegate = {
        return SessionDelegate()
    }()
    // Hold the KVO observers as we want to keep oberving in the extension life time.
    //
    private var activationStateObservation: NSKeyValueObservation?
    private var hasContentPendingObservation: NSKeyValueObservation?
    private var deviceServices = [LocationService.self, GyroService.self,
                                  MotionService.self, MagnometerService.self,
                                  AccelerometerService.self, PedometerService.self] as [Any]
    // An array to keep the background tasks.
    //
    private var wcBackgroundTasks = [WKWatchConnectivityRefreshBackgroundTask]()
    // WKWatchConnectivityRefreshBackgroundTask should be completed – Otherwise they will keep consuming
    // the background executing time and eventually causes an app crash.
    // The timing to complete the tasks is when the current WCSession turns to not .activated or
    // hasContentPending flipped to false (see completeBackgroundTasks), so KVO is set up here to observe
    // the changes if the two properties.
    //
    override init() {
        activationStateObservation = WCSession.default.observe(\.activationState) { _, _ in
            DispatchQueue.main.async {
                self.completeBackgroundTasks()
            }
        }
        hasContentPendingObservation = WCSession.default.observe(\.hasContentPending) { _, _ in
            DispatchQueue.main.async {
                self.completeBackgroundTasks()
            }
        }
    }

    public func applicationDidFinishLaunching() {
        Resolver.registerAllServices()
        let locationService = Resolver.resolve(LocationService.self, name: "LocationService", args: nil)
        let gyroService = Resolver.resolve(GyroService.self, name: "GyroService", args: nil)
        let pedometerService = Resolver.resolve(PedometerService.self, name: "PedometerService", args: nil)
        let accelerometerService = Resolver.resolve(AccelerometerService.self, name: "AccelerometerService", args: nil)
        let motionService = Resolver.resolve(MotionService.self, name: "MotionService", args: nil)
        let magnometerService = Resolver.resolve(MagnometerService.self, name: "MagnometerService", args: nil)
        deviceServices = [locationService, gyroService, pedometerService, accelerometerService, motionService, magnometerService]
        _ = deviceServices.map {
            ($0 as? ServiceLifecycle).start()
        }
    }

    public func applicationDidBecomeActive() {
    }

    public func applicationWillResignActive() {
    }

    public func applicationWillEnterForeground() {
    }

    public func applicationDidEnterBackground() {
    }

    public func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

    // Compelete the background tasks, and schedule a snapshot refresh.
    //
    func completeBackgroundTasks() {
        guard !wcBackgroundTasks.isEmpty else { return }

        guard WCSession.default.activationState == .activated,
            WCSession.default.hasContentPending == false else { return }

        wcBackgroundTasks.forEach { $0.setTaskCompleted() }

        // Use Logger to log the tasks for debug purpose. A real app may remove the log
        // to save the precious background time.
        //
        Logger.shared.append(line: "\(#function):\(wcBackgroundTasks) was completed!")

        // Schedule a snapshot refresh if the UI is updated by background tasks.
        //
        let date = Date(timeIntervalSinceNow: 1)
        WKExtension.shared().scheduleSnapshotRefresh(withPreferredDate: date, userInfo: nil) { error in

            if let error = error {
                print("scheduleSnapshotRefresh error: \(error)!")
            }
        }
        wcBackgroundTasks.removeAll()
    }
}
