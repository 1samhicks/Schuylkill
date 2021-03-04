//
//  File.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/1/21.
//

import Foundation
import Resolver

public protocol ResolverRegistrant {
    init()
}

extension ResolverRegistrant {
    public static var name: String {
        return String(describing: self)
    }
    
    var name : String {
        get {
            return type(of: self).name
        }
    }
}
