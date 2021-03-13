//
//  File.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/1/21.
//

import Foundation
import Resolver
#if !os(watchOS)
import OSLog
#endif

public protocol ServiceNaming {
    init()
}
