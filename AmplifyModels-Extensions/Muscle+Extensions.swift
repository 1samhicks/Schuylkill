//
//  Muscle+Extensions.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/10/21.
//
import Combine
import Amplify

extension Muscle {
    
    public init(friendlyName: String) {
        self.init(id: UUID().uuidString, friendlyName: friendlyName, scientificName: "", image: "", createdAt: Temporal.DateTime.now(), updatedAt: Temporal.DateTime.now(), deleted: nil, exercisemachineID: "")
        
    }
}

extension Muscle {
    #if MOCK
    static let muscles : [Muscle] = [Muscle(friendlyName: "Abs"),
                                     Muscle(friendlyName: "Lats"),
                                     Muscle(friendlyName: "Pecs")]
    #endif
}
