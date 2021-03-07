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
        
        func setupWatchConnectivity(delegate : WatchSessionChannelDelegate) throws {
            guard WCSession.isSupported() else {
                throw ApplicationRuntimeError.WatchConfigurationIssue("WCSession.isSupported() returned false for this iOS device")
            }
            guard !WatchSettings.sharedContainerID.isEmpty else {
                throw ApplicationRuntimeError.WatchConfigurationIssue("Specify a shared container ID for WatchSettings.sharedContainerID to use watch settings!")
            }
            
            WCSession.default.delegate = delegate
            WCSession.default.activate()
        }
    }
