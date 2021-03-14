//
//  FitnessCenter+Extensions.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/21/21.
//

import Amplify
import CoreLocation
import Foundation

extension FitnessCenter {
    static func create(withCenter center: FitnessCenter) throws {
        Amplify.DataStore.save(center) { result in
            switch result {
            case .success(let savedItem):
                print("Saved item: \(savedItem.id)")
            case .failure(let error):
                print("Could not save item to DataStore: \(error)")
            }
        }
    }

    static func query() {
        Amplify.DataStore.query(FitnessCenter.self) { result in
            switch result {
            case .success(let items):
                for item in items {
                    print("FitnessCenter ID: \(item.id)")
                }
            case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
        }
    }

    func update() {
        Amplify.DataStore.save(self) { result in
            switch result {
            case .success(let savedItem):
                print("Saved item: \(savedItem.id)")
            case .failure(let error):
                print("Could not save item to DataStore: \(error)")
            }
        }
    }

    func delete() {
        Amplify.DataStore.delete(self) { result in
            switch result {
            case .success:
                print("Deleted item: \(self.id)")
            case .failure(let error):
                print("Could not update data in Datastore: \(error)")
            }
        }
    }
}
