//
//  AmplifyService+Muscles.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/2/21.
//

import Foundation
import Amplify

extension AmplifyAPIService {
    static func saveAll(muscles : [Muscle]) {
        muscles.forEach { (m) in
            Amplify.DataStore.save(m) { result in
               switch(result) {
               case .success(let savedItem):
                   print("Saved item: \(savedItem.friendlyName)")
               case .failure(let error):
                   print("Could not save item to datastore: \(error)")
               }
            }
        }
    }
}
