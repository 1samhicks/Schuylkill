//
//  UIApplication.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/24/21.
//

import Amplify
import AmplifyPlugins
import Foundation
import WatchConnectivity
import UIKit

    public extension UIApplication {

        var FirebaseInfoPlist: [[String: String]]? {
            guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") else {
                return nil
            }
            let url = URL(fileURLWithPath: path)
            let data = try! Data(contentsOf: url)
            guard let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [[String: String]] else {
                return nil
            }
            print(plist)
            return plist
        }

        func convertErrorToString(_ error: Error) -> String {
            return """
            Domain: \((error as NSError).domain)
            Code: \((error as NSError).code)
            Description: \(error.localizedDescription)
            Failure Reason: \((error as NSError).localizedFailureReason ?? "nil")
            Suggestions: \((error as NSError).localizedRecoverySuggestion ?? "nil")\n
            """
        }
        
    }
