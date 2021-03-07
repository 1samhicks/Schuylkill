//
//  SwiftyBeaver.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/7/21.
//

import Foundation
import SwiftyBeaver

extension SwiftyBeaver {
    public static func activate() {
        // add log destinations. at least one is needed!
        let console = ConsoleDestination()  // log to Xcode Console
        let file = FileDestination()  // log to default swiftybeaver.log file
        //let cloud = SBPlatformDestination(appID: "foo", appSecret: "bar", encryptionKey: "123") // to cloud
        console.format = "$DHH:mm:ss$d $L $M"
        
        log.addDestination(console)
        log.addDestination(file)
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
