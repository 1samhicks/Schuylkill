//
//  App.swift
//  Schuylkill-App WatchKit Extension
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import SwiftUI

@main
struct WatchApp : App {
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self) var extensionDelegate
    var body: some Scene {
        WindowGroup {
        }
    }
    
    public init() {
        
    }
    
   
}
