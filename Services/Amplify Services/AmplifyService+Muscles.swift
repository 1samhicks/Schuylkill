//
//  AmplifyService+Muscles.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/2/21.
//

import Amplify
import Foundation

extension AmplifyAPIService {
    static func saveAll(muscles: [Muscle]) {
        muscles.forEach { muscle in
            Amplify.DataStore.save(muscle) { result in
               switch result {
               case .success(let savedItem):
                   print("Saved item: \(savedItem.friendlyName)")
               case .failure(let error):
                   print("Could not save item to datastore: \(error)")
               }
            }
        }
    }
}
