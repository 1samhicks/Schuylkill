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

    var name: String {
        get {
            return type(of: self).name
        }
    }
}
