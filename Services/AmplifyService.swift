//
//  AmplifyService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/10/21.
//

import Foundation
import Amplify
import CoreLocation



public class AmplifyService : ObservableObject, RuntimeService {
    //@Published var user: User?
    
    func retrieveFitnessCenterData(at location: Location? = nil) {
        
    }
    
    
    func startWorkout(with workout: GymWorkout? = nil) {
        
    }
    
    func endWorkout(with workout: GymWorkout? = nil) {
        
    }
    
    func addExerciseMachine(_ machine: ExerciseMachine, withLocation location: Location, at: FitnessCenter) {
        
    }
    
    func addExerciseSet(withMachine machine:ExerciseMachine, andReps:[ExerciseRep], from:Temporal.DateTime, to:Temporal.DateTime) {
        
    }
    
    
}
