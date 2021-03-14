//
//  AppSettings.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/5/21.
//

import Foundation
/****
 Data that needs to be persisted across sessions.
 */
struct AppData {
    @Storage(key: "machineRegionDistance", defaultValue: 3.0)
        static var machineRegionDistance: Double
    @Storage(key: "currentMachine", defaultValue: nil)
        static var currentMachine : ExerciseMachine?
    @Storage(key: "currentWorkout", defaultValue: nil)
        static var currentWorkout : GymWorkout?
    @Storage(key: "currentFitnessCenter", defaultValue: nil)
        static var currentFitnessCenter : FitnessCenter?
    @Storage(key: "userData", defaultValue: nil)
        static var userData : UserData?
}
