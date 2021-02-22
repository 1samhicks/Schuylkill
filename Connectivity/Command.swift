//
//  Command.swift
//  Schuylkill
//
//  Created by Sam Hicks on 2/3/21.
//

import Foundation

// Constants to identify the Watch Connectivity methods, also used as user-visible strings in UI.
//
enum Command: String {
    case updateAppContext = "UpdateAppContext"
    case sendMessage = "SendMessage"
    case sendMessageData = "SendMessageData"
    case transferUserInfo = "TransferUserInfo"
    case transferFile = "TransferFile"
    case transferCurrentComplicationUserInfo = "TransferComplicationUserInfo"
}


