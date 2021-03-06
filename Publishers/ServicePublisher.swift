//
//  ServicePublisher.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import Combine

protocol ServicePublisher : Publisher  {

    func send(input: Event)

    func send(error: Error)

    func sendFinished()
}
