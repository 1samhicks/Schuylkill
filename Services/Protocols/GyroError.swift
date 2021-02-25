//
//  GyroError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Foundation

open class GyroError : Error {
    var innerError : Error
    init(error : Error) {
        innerError = error
    }
}
