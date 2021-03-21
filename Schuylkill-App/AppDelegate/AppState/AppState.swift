//
//  AppState.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/14/21.
//

import Foundation
import WatchConnectivity
import Amplify
import AmplifyPlugins
/*
 func buffer(size: Int, prefetch: Publishers.PrefetchStrategy, whenFull: Publishers.BufferingStrategy<Failure>) -> Publishers.Buffer<Fail<Output, Failure>>
 */
struct AppState {
    @Storage(key: "machine_region_distance", defaultValue: 3.0)
        static var machineRegionDistance: Double
    @Storage(key: "current_machine", defaultValue: nil)
        static var currentMachine: ExerciseMachine?
    @Storage(key: "current_workout", defaultValue: nil)
        static var currentWorkout: GymWorkout?
    @Storage(key: "current_fitness_center", defaultValue: nil)
        static var currentFitnessCenter: FitnessCenter?
    @Storage(key: "user_data", defaultValue: nil)
        static var userData: UserData?
    
    private var watchSessionChannelDelegate = WatchSessionChannelDelegate()
    private var userNotifications = UNUserNotificationCenterCoordinator()
    
    public func configureAmplify() throws {
        try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels()))
        try Amplify.add(plugin: AWSCognitoAuthPlugin())
        try Amplify.add(plugin: AWSAPIPlugin())
        try Amplify.add(plugin: AWSPinpointAnalyticsPlugin())
        try Amplify.add(plugin: AWSS3StoragePlugin())
        Amplify.Logging.logLevel = .verbose
        try Amplify.configure()
    }
    
    public var userNotif : UNUserNotificationCenterCoordinator {
        get { UNUserNotificationCenterCoordinator() }
    }
    
    
    public var sessionDelegate : WatchSessionChannelDelegate {
        get { watchSessionChannelDelegate }
    }
    
    func configureWatchConnectivity(delegate: WatchSessionChannelDelegate) throws {
        guard WCSession.isSupported() else {
            throw ApplicationRuntimeError.WatchConfigurationIssue("WCSession.isSupported() returned false for this iOS device")
        }
        guard !WatchSettings.sharedContainerID.isEmpty else {
            throw ApplicationRuntimeError.WatchConfigurationIssue("Specify a shared container ID for WatchSettings.sharedContainerID to use watch settings!")
        }
        WCSession.default.delegate = delegate
        WCSession.default.activate()
    }
    
}
