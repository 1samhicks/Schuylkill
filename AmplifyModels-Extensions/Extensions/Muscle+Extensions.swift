//
//  Muscle+Extensions.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/10/21.
//
import Amplify
import Combine

public extension Muscle {
    init(friendlyName: String) {
        self.init(id: UUID().uuidString,
                  friendlyName: friendlyName,
                  scientificName: "",
                  image: "",
                  createdAt: Temporal.DateTime.now(),
                  updatedAt: Temporal.DateTime.now(),
                  deleted: nil,
                  exercisemachineID: "")
    }
}


