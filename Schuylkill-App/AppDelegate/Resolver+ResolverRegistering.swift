//
//  AppDelegate+Injection.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/10/21.
//

import Foundation
import Resolver
import SwifterSwift

#if MOCK
extension Resolver {
    static var mock = Resolver(parent: main)
}
#endif

