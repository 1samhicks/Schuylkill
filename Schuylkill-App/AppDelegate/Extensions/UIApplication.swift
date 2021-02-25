//
//  UIApplication.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/24/21.
//

import Foundation
import WatchConnectivity
import UIKit

    extension UIApplication {
        
        var FIREBASE_INFO_PLIST : [[String:String]]? {
            guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") else {
                return nil
            }
            let url = URL(fileURLWithPath: path)
            let data = try! Data(contentsOf: url)
            guard let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [[String:String]] else {
                return nil
            }
            print(plist)
            return plist
        }
        
        func setupWatchConnectivity(delegate : WatchSessionChannelDelegate) {
            assert(WCSession.isSupported(), "This sample requires Watch Connectivity support!")
            WCSession.default.delegate = delegate
            WCSession.default.activate()
            
            // Remind the setup of WatchSettings.sharedContainerID.
            //
            if WatchSettings.sharedContainerID.isEmpty {
                print("Specify a shared container ID for WatchSettings.sharedContainerID to use watch settings!")
            }
        }
    }
