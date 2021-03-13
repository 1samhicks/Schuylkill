//
//  ServiceLifecycle.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/13/21.
//

import Foundation

protocol ServiceLifecycle {
    func start()
    func pause()
    func restart()
    func terminate()
}
