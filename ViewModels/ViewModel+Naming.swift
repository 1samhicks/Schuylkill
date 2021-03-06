//
//  ViewModel+Naming.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Foundation
import Resolver

protocol ViewModel : ResolverRegistrant {
    init()
}


extension ViewModel {
    
    public var viewModelType : ViewModel.Type {
        return ViewModel.self as! ViewModel.Type
    }
}

