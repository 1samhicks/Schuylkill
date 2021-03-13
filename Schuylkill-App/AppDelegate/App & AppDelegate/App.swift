//
//  Schuylkill_AppApp.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/5/21.
//

import SwiftUI
import Amplify
import AWSS3
import AmplifyPlugins
import AmplifyPlugins.Swift
import Resolver
import Foundation
import UIKit
import WatchConnectivity
import RxSwift
import RxCocoa
import CoreMotion
import SwiftyBeaver

@main
struct Shredded: App {
    // var firstView = try! ApplicationLoadFactory.getFirstView()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }

    public init() {

    }
}

