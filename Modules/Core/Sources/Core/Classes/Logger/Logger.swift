//
//  Logger.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 24/02/26.
//

import Foundation
import OSLog

public class Logger {
    public static func log(_ message: Any) {
        if #available(iOS 14.0, *), let logMessage = message as? String {
            Logger.app.log("\(logMessage)")
        } else {
            print(message)
        }
    }

    public static func info(_ message: Any) {
        if #available(iOS 14.0, *), let logMessage = message as? String {
            Logger.app.info("\(logMessage)")
        } else {
            print(message)
        }
    }

    public static func warning(_ message: Any) {
        if #available(iOS 14.0, *), let logMessage = message as? String {
            Logger.app.warning("\(logMessage)")
        } else {
            print(message)
        }
    }

    public static func error(_ message: Any) {
        if #available(iOS 14.0, *), let logMessage = message as? String {
            Logger.app.critical("\(logMessage)")
        } else {
            print(message)
        }
    }
}


@available(iOS 14.0, *)
extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier!
    
    static let app = os.Logger(subsystem: subsystem, category: "app")
}
