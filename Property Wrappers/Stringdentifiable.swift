//
//  MyIdentifiable.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/6/21.
//

import Foundation

protocol StringIdentifiable: Identifiable {
    var id: ObjectIdentifier { get set }

    typealias ObjectIdentifier = String

  // Implement protocol requirements here
}
