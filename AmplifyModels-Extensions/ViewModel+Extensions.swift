//
//  Model+Extensions.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Amplify
import Foundation

protocol ViewModel {
}

extension ViewModel {
    public static var modelName: String {
        return String(describing: self)
    }

    public var modelName: String {
        return Self.modelName
    }
}
