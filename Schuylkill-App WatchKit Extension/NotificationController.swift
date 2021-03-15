//
//  NotificationController.swift
//  Schuylkill-App WatchKit Extension
//
//  Created by Sam Hicks on 2/5/21.
//

import SwiftUI
import UserNotifications
import SwiftyBeaver
import UIKit
import WatchConnectivity
import ClockKit

#if os(watchOS)

class NotificationController: WKWKUserNotificationHostingController<NotificationView> {
    override var body: NotificationView {
        return NotificationView()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceive(_ notification: UNNotification) {
        // This method is called when a notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
    }
    var transport: GDTCORTransport = GDTCORTransport(mappingID: "1018", transformers: nil,
                                                     target: GDTCORTarget.FLL)!

    func generateDataEventCompanion(sender: AnyObject?) {
         /*
          Beaver("Generating data event on Companion watch app")
          let transportToUse = transport
          let event: GDTCOREvent = transportToUse.eventForTransport()
          let testMessage = FirelogTestMessageHolder()
          
          testMessage.root.identifier = "watchos_companion_test_app_data_event"
          testMessage.root.repeatedID = ["id1", "id2", "id3"]
          testMessage.root.warriorChampionships = 1_111_110
          testMessage.root.subMessage.starTrekData = "technoBabble".data(using: String.Encoding.utf8)!
          testMessage.root.subMessage.repeatedSubMessage = [
            
            SubMessageTwo(),
            SubMessageTwo()
          
          ]
          testMessage.root.subMessage.repeatedSubMessage[0].samplingPercentage = 13.37
          event.dataObject = testMessage
          let encoder = JSONEncoder()
          if let jsonData = try? encoder.encode(["needs_network_connection_info": true]) {
            event.customBytes = jsonData
          }
          transportToUse.sendDataEvent(event)*/
    }

    private func generateTelemetryEventCompanion(sender: AnyObject?) {
        /*
      print("Generating telemetry event on Companion watch app")
      let transportToUse = transport
      let event: GDTCOREvent = transportToUse.eventForTransport()
      let testMessage = FirelogTestMessageHolder()
      testMessage.root.identifier = "watchos_companion_test_app_telemetry_event"
      testMessage.root.warriorChampionships = 1000
      testMessage.root.subMessage.repeatedSubMessage = [
        SubMessageTwo(),
      ]
      event.dataObject = testMessage
      let encoder = JSONEncoder()
      if let jsonData = try? encoder.encode(["needs_network_connection_info": true]) {
        event.customBytes = jsonData
      }
      transportToUse.sendTelemetryEvent(event)
 */
    }

    private func generateHighPriorityEventCompanion(sender: AnyObject?) {
        /*
      print("Generating high priority event on Companion watch app")
      let transportToUse = transport
      let event: GDTCOREvent = transportToUse.eventForTransport()
      let testMessage = FirelogTestMessageHolder()
      testMessage.root.identifier = "watchos_companion_test_app_high_priority_event"
      testMessage.root.repeatedID = ["id1", "id2", "id3"]
      testMessage.root.warriorChampionships = 1337
      event.qosTier = GDTCOREventQoS.qoSFast
      event.dataObject = testMessage
      let encoder = JSONEncoder()
      if let jsonData = try? encoder.encode(["needs_network_connection_info": true]) {
        event.customBytes = jsonData
      }
      transportToUse.sendDataEvent(event)
 */
    }

    private func generateWifiOnlyEventCompanion(sender: AnyObject?) {
        /*
      print("Generating wifi only event on Companion watch app")
      let transportToUse = transport
      let event: GDTCOREvent = transportToUse.eventForTransport()
      let testMessage = FirelogTestMessageHolder()
      testMessage.root.identifier = "watchos_companion_test_app_wifi_only_event"
      event.qosTier = GDTCOREventQoS.qoSWifiOnly
      event.dataObject = testMessage
      let encoder = JSONEncoder()
      if let jsonData = try? encoder.encode(["needs_network_connection_info": true]) {
        event.customBytes = jsonData
      }
      transportToUse.sendDataEvent(event)
 */
    }

    private func generateDailyEventCompanion(sender: AnyObject?) {
        /*
      print("Generating daily only event on Companion watch app")
      let transportToUse = transport
      let event: GDTCOREvent = transportToUse.eventForTransport()
      let testMessage = FirelogTestMessageHolder()
      testMessage.root.identifier = "watchos_companion_test_app_daily_event"
      testMessage.root.repeatedID = ["id1", "id2", "id3"]
      testMessage.root.warriorChampionships = 9001
      testMessage.root.subMessage.starTrekData = "engage!".data(using: String.Encoding.utf8)!
      testMessage.root.subMessage.repeatedSubMessage = [
        SubMessageTwo(),
      ]
      testMessage.root.subMessage.repeatedSubMessage[0].samplingPercentage = 100.0
      event.qosTier = GDTCOREventQoS.qoSDaily
      event.dataObject = testMessage
      let encoder = JSONEncoder()
      if let jsonData = try? encoder.encode(["needs_network_connection_info": true]) {
        event.customBytes = jsonData
      }
      transportToUse.sendDataEvent(event)
 */
    }

}

#endif
