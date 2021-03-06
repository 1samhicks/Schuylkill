//
//  WCSessionDelegate.swift
//  Schuylkill
//
//  Created by Sam Hicks on 2/3/21.
//

import ClockKit
import Foundation
import WatchConnectivity

extension Notification.Name {
    static let dataDidFlow = Notification.Name("DataDidFlow")
    static let activationDidComplete = Notification.Name("ActivationDidComplete")
    static let reachabilityDidChange = Notification.Name("ReachabilityDidChange")
}

public class WatchSessionChannelDelegate: NSObject, WCSessionDelegate {
    // Called when WCSession activation state is changed.
    //
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        postNotificationOnMainQueueAsync(name: .activationDidComplete)
    }

    // Called when WCSession reachability is changed.
    //
    public func sessionReachabilityDidChange(_ session: WCSession) {
        postNotificationOnMainQueueAsync(name: .reachabilityDidChange)
    }

    // Called when an app context is received.
    //
    public func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        let commandStatus = CommandStatus(command: .updateAppContext, phrase: .received)
        // commandStatus.timedColor = TimedColor(applicationContext)
        postNotificationOnMainQueueAsync(name: .dataDidFlow, object: commandStatus)
    }

    // Called when a message is received and the peer doesn't need a response.
    //
    public func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        let commandStatus = CommandStatus(command: .sendMessage, phrase: .received)
        // commandStatus.timedColor = TimedColor(message)
        postNotificationOnMainQueueAsync(name: .dataDidFlow, object: commandStatus)
    }

    // Called when a message is received and the peer needs a response.
    //
    public func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
        self.session(session, didReceiveMessage: message)
        replyHandler(message) // Echo back the time stamp.
    }

    // Called when a piece of message data is received and the peer doesn't need a response.
    //
    public func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        let commandStatus = CommandStatus(command: .sendMessageData, phrase: .received)
        // commandStatus.timedColor = TimedColor(messageData)
        postNotificationOnMainQueueAsync(name: .dataDidFlow, object: commandStatus)
    }

    // Called when a piece of message data is received and the peer needs a response.
    //
    public func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        self.session(session, didReceiveMessageData: messageData)
        replyHandler(messageData) // Echo back the time stamp.
    }

    // Called when a userInfo is received.
    //
    public func session(_ session: WCSession, didReceiveUserInfo userInfo: [String: Any] = [:]) {
        var commandStatus = CommandStatus(command: .transferUserInfo, phrase: .received)
        // commandStatus.timedColor = TimedColor(userInfo)

        if let isComplicationInfo = userInfo[PayloadKey.isCurrentComplicationInfo] as? Bool,
            isComplicationInfo == true {
            commandStatus.command = .transferCurrentComplicationUserInfo

            #if os(watchOS)
            let server = CLKComplicationServer.sharedInstance()
            if let complications = server.activeComplications {
                for complication in complications {
                    // Call this method sparingly. If your existing complication data is still valid,
                    // consider calling the extendTimeline(for:) method instead.
                    server.reloadTimeline(for: complication)
                }
            }
            #endif
        }
        postNotificationOnMainQueueAsync(name: .dataDidFlow, object: commandStatus)
    }

    // Called when sending a userInfo is done.
    //
    public func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        var commandStatus = CommandStatus(command: .transferUserInfo, phrase: .finished)
       // commandStatus.timedColor = TimedColor(userInfoTransfer.userInfo)

        #if os(iOS)
        if userInfoTransfer.isCurrentComplicationInfo {
            commandStatus.command = .transferCurrentComplicationUserInfo
        }
        #endif

        if let error = error {
            commandStatus.errorMessage = error.localizedDescription
        }
        postNotificationOnMainQueueAsync(name: .dataDidFlow, object: commandStatus)
    }

    // Called when a file is received.
    //
    public func session(_ session: WCSession, didReceive file: WCSessionFile) {
        var commandStatus = CommandStatus(command: .transferFile, phrase: .received)
        commandStatus.file = file
        // commandStatus.timedColor = TimedColor(file.metadata!)

        // Note that WCSessionFile.fileURL will be removed once this method returns,
        // so instead of calling postNotificationOnMainQueue(name: .dataDidFlow, userInfo: userInfo),
        // we dispatch to main queue SYNCHRONOUSLY.
        //
        DispatchQueue.main.sync {
            NotificationCenter.default.post(name: .dataDidFlow, object: commandStatus)
        }
    }

    // Called when a file transfer is done.
    //
    public func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        var commandStatus = CommandStatus(command: .transferFile, phrase: .finished)

        if let error = error {
            commandStatus.errorMessage = error.localizedDescription
            postNotificationOnMainQueueAsync(name: .dataDidFlow, object: commandStatus)
            return
        }
        commandStatus.fileTransfer = fileTransfer
        // commandStatus.timedColor = TimedColor(fileTransfer.file.metadata!)

        #if os(watchOS)
        if WatchSettings.sharedContainerID.isEmpty == false {
            let defaults = UserDefaults(suiteName: WatchSettings.sharedContainerID)
            if let enabled = defaults?.bool(forKey: WatchSettings.clearLogsAfterTransferred), enabled {
                // Logger.shared.clearLogs()
            }
        }
        #endif
        postNotificationOnMainQueueAsync(name: .dataDidFlow, object: commandStatus)
    }

    // WCSessionDelegate methods for iOS only.
    //
    #if os(iOS)
    public func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }

    public func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        session.activate()
    }

    public func sessionWatchStateDidChange(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    #endif

    // Post a notification on the main thread asynchronously.
    //
    private func postNotificationOnMainQueueAsync(name: NSNotification.Name, object: CommandStatus? = nil) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: name, object: object)
        }
    }}
