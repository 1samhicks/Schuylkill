//
//  Deletable.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/2/21.
//

import Foundation

protocol Deletable {
    var deleted: Bool? { get set }
}

extension ExerciseMachine: Deletable {}

extension ExerciseRep: Deletable {}

extension ExerciseSet: Deletable {}

extension FitnessCenter: Deletable {}

extension GymWorkout: Deletable {}

extension Location: Deletable {}

extension Muscle: Deletable {}

extension MotionAttitude: Deletable {}

extension AccelerometerReading: Deletable {}
