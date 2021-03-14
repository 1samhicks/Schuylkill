//
//  Location+Extensions.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/21/21.
//

import Amplify
import CoreLocation
import Foundation

extension Location {
    static func create(location: CLLocation) -> Location {
        let item = Location(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude,
                createdAt: Temporal.DateTime.now(),
                updatedAt: Temporal.DateTime.now(),
                deleted: false)
        Amplify.DataStore.save(item) { result in
            switch result {
            case .success(let savedItem):
                print("Saved item: \(savedItem.id)")
            case .failure(let error):
                print("Could not save item to DataStore: \(error)")
            }
        }
        return item
    }
}
