//
//  TestDataProvider.swift
//  Schuylkill
//
//  Created by Sam Hicks on 2/3/21.
//

import Foundation

// Define the interfaces for providing payload for Watch Connectivity APIs.
// MainViewController and MainInterfaceController adopt this protocol.
//
protocol TestDataProvider {
    var appContext: [String: Any] { get }
    
    var message: [String: Any] { get }
    var messageData: Data { get }
    
    var userInfo: [String: Any] { get }
    
    var file: URL { get }
    var fileMetaData: [String: Any] { get }
}
