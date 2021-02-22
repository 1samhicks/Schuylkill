//
//  Muscle+Extensions.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/10/21.
//
import Combine
import Amplify

extension Muscle {
    
    init(friendlyName: String) {
        self.init(id: UUID().uuidString, friendlyName: friendlyName, scientificName: "", image: "", createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now(), deleted: nil, exercisemachineID: "")
        
    }
    
    static let muscles : [Muscle] = [Muscle(friendlyName: "Abs"),
                                     Muscle(friendlyName: "Lats"),
                                     Muscle(friendlyName: "Pecs")]
    static func saveAll() {
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
