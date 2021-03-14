//
//  SwiftyBeaver.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/7/21.
//

import Disk
import Foundation
import SwiftyBeaver

extension SwiftyBeaver {
    typealias Secrets = SensitiveConstants.SwiftyBeaver

    public static func activate() {
        // add log destinations. at least one is needed!
        let console = ConsoleDestination()  // log to Xcode Console
        // let cloud = SBPlatformDestination(appID: "foo", appSecret: "bar", encryptionKey: "123") // to cloud
        console.format = "$DHH:mm:ss$d $L $M"

        applicationLog.addDestination(console)
        applicationLog.addDestination(BaseDestination())
        applicationLog.addDestination(SBPlatformDestination(appID: Secrets.APP_ID, appSecret: Secrets.APP_SECRET, encryptionKey: Secrets.ENCRYPTION_KEY))
    }

    public static func exceptionThrown(error: Error) {
        applicationLog.error(error)
    }

    public static func exceptionThrown(args: [String: String]) {
        applicationLog.error(args)
    }
}

extension SwiftyBeaver {
    class Naming {
        static let error = "error"
        static let RecoverySuggestion = "Recovery Suggestion"
        static let ErrorDescription = "Error Description"
    }
}
