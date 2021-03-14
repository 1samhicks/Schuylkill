//
//  ExerciseMachine+Extensions.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/10/21.
//

import Amplify
import CoreLocation
import Foundation

extension ExerciseMachine {
    static func createNewMachine(name: String, loc: CLLocation, Id: String = UUID().uuidString) throws {
        let item = ExerciseMachine(
                machineName: name,
                image: nil,
                createdAt: Temporal.DateTime.now(),
                updatedAt: Temporal.DateTime.now(),
                deleted: false,
                Muscles: [],
            MachineLocation: Location.create(location: loc))

        Amplify.DataStore.save(item) { result in
            switch result {
            case .success(let savedItem):
                print("Saved item: \(savedItem.id)")
            case .failure(let error):
                print("Could not save item to DataStore: \(error)")
            }
        }
    }
}
