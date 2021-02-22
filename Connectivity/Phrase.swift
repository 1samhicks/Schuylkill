//
//  Phrase.swift
//  Schuylkill
//
//  Created by Sam Hicks on 2/3/21.
//

import Foundation

// Constants to identify the phrases of a Watch Connectivity communication.
//
enum Phrase: String {
    case updated = "Updated"
    case sent = "Sent"
    case received = "Received"
    case replied = "Replied"
    case transferring = "Transferring"
    case canceled = "Canceled"
    case finished = "Finished"
    case failed = "Failed"
}
