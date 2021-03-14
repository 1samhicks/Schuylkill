//
//  PluginError.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/7/21.
//

import Amplify
import AmplifyPlugins
import Foundation
extension PluginError: ErrorHandling {}

extension ConfigurationError: ErrorHandling {}

extension LoggingError: ErrorHandling {}

extension AnalyticsError: ErrorHandling {}
