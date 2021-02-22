//
//  PayloadKey.swift
//  Schuylkill
//
//  Created by Sam Hicks on 2/3/21.
//

import Foundation

// Constants to access the payload dictionary.
// isCurrentComplicationInfo is to tell if the userInfo is from transferCurrentComplicationUserInfo
// in session:didReceiveUserInfo: (see SessionDelegater).
//
struct PayloadKey {
    static let timeStamp = "timeStamp"
    static let colorData = "colorData"
    static let isCurrentComplicationInfo = "isCurrentComplicationInfo"
}
