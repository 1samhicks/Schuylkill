//
//  ServiceNaming.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/13/21.
//

import Foundation

extension ServiceNaming {
    public static var name: String {
        return String(describing: self)
    }

    public var name: String {
            Self.name
    }
}
