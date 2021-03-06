//
//  GymWorkout+Extensions.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/21/21.
//

import Foundation
import Amplify

extension GymWorkout {
    
    static func create() -> GymWorkout {
        let item = GymWorkout(
                startedAt: Temporal.DateTime.now(),
                FitnessCenter: nil,
                endedAt: Temporal.DateTime.now(),
                updatedAt: Temporal.DateTime.now(),
                createdAt: Temporal.DateTime.now(),
                deleted: true)
        Amplify.DataStore.save(item) { result in
            switch(result) {
            case .success(let savedItem):
                print("Saved item: \(savedItem.id)")
            case .failure(let error):
                print("Could not save item to DataStore: \(error)")
            }
        }
        return item
    }
    
    func update() {
        Amplify.DataStore.save(self) { result in
            switch(result) {
            case .success(let savedItem):
                print("Saved item: \(savedItem.id)")
            case .failure(let error):
                print("Could not save item to DataStore: \(error)")
            }
        }
    }
    
    func delete() {
        Amplify.DataStore.delete(self) { result in
            switch(result) {
            case .success:
                print("Deleted item: \(id)")
            case .failure(let error):
                print("Could not update data in Datastore: \(error)")
            }
        }
    }
    
    
    func query() {
        Amplify.DataStore.query(GymWorkout.self) { result in
            switch(result) {
            case .success(let items):
                for item in items {
                    print("GymWorkout ID: \(item.id)")
                }
            case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
        }
    }
    
}
