//
//  CommandStatus.swift
//  Schuylkill
//
//  Created by Sam Hicks on 2/3/21.
//

import Foundation
import WatchConnectivity
// Wrap the command status to bridge the commands status and UI.
//
struct CommandStatus {
    var command: Command
    var phrase: Phrase
    var fileTransfer: WCSessionFileTransfer?
    var file: WCSessionFile?
    var userInfoTranser: WCSessionUserInfoTransfer?
    var errorMessage: String?
    
    init(command: Command, phrase: Phrase) {
        self.command = command
        self.phrase = phrase
    }
}
