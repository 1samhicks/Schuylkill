//
//  UIApplication.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/24/21.
//

import Foundation
import WatchConnectivity
import UIKit

struct AppData {
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
}

    extension UIApplication {

        var FirebaseInfoPlist: [[String: String]]? {
            guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") else {
                return nil
            }
            let url = URL(fileURLWithPath: path)
            let data = try! Data(contentsOf: url)
            guard let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [[String: String]] else {
                return nil
            }
            print(plist)
            return plist
        }

        func setupWatchConnectivity(delegate: WatchSessionChannelDelegate) throws {
            guard WCSession.isSupported() else {
                throw ApplicationRuntimeError.WatchConfigurationIssue("WCSession.isSupported() returned false for this iOS device")
            }
            guard !WatchSettings.sharedContainerID.isEmpty else {
                throw ApplicationRuntimeError.WatchConfigurationIssue("Specify a shared container ID for WatchSettings.sharedContainerID to use watch settings!")
            }
            WCSession.default.delegate = delegate
            WCSession.default.activate()
        }

        func convertErrorToString(_ error: Error) -> String {
            return """
            Domain: \((error as NSError).domain)
            Code: \((error as NSError).code)
            Description: \(error.localizedDescription)
            Failure Reason: \((error as NSError).localizedFailureReason ?? "nil")
            Suggestions: \((error as NSError).localizedRecoverySuggestion ?? "nil")\n
            """
        }
    }
