//
//  ViewModel+Naming.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/28/21.
//

import Foundation
import Resolver

protocol ViewModel: ServiceNaming {
    init()
}

internal extension ViewModel {
    var viewModelType: ViewModel.Type {
        return ViewModel.self as! ViewModel.Type
    }
}
