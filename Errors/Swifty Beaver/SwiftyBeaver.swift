//
//  SwiftyBeaver.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/7/21.
//

import Foundation
import SwiftyBeaver
import Disk

extension SwiftyBeaver {
    typealias secrets = SensitiveConstants.SwiftyBeaver
    
    public static func activate() {
        // add log destinations. at least one is needed!
        let console = ConsoleDestination()  // log to Xcode Console
        //let cloud = SBPlatformDestination(appID: "foo", appSecret: "bar", encryptionKey: "123") // to cloud
        console.format = "$DHH:mm:ss$d $L $M"
        
        log.addDestination(console)
        log.addDestination(BaseDestination())
        log.addDestination(SBPlatformDestination(appID: secrets.APP_ID, appSecret: secrets.APP_SECRET, encryptionKey: secrets.ENCRYPTION_KEY))
    }
    
    public static func exceptionThrown(error : Error) {
        log.error(error)
    }
    
    public static func exceptionThrown(args : [String : String]) {
        log.error(args)
    }
}

extension SwiftyBeaver {
    class Naming {
        static let error = "error"
        static let recovery_suggestion = "Recovery Suggestion"
        static let error_description = "Error Description"
    }
}
