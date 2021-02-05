//
//  Schuylkill_AppApp.swift
//  Schuylkill-App WatchKit Extension
//
//  Created by Sam Hicks on 2/5/21.
//

import SwiftUI

@main
struct Schuylkill_AppApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
