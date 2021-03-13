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
    @Storage(key: "machine_region_distance", defaultValue: 3.0)
        static var machine_region_distance: Double
    @Storage(key: "current_machine", defaultValue: nil)
        static var current_machine : ExerciseMachine?
    @Storage(key: "current_workout", defaultValue: nil)
        static var current_workout : GymWorkout?
    @Storage(key: "current_fitness_center", defaultValue: nil)
        static var current_fitness_center : FitnessCenter?
    @Storage(key: "user_data", defaultValue: nil)
        static var user_data : UserData?
}
