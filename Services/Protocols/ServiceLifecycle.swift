//
//  ServiceLifecycle.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/13/21.
//

import Foundation

protocol ServiceLifecycle {
    var state: ServiceState? { get set }
    func start()
    func pause()
    func restart()
    func terminate()
}
