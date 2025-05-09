//
//  Logger.swift
//  BrowseNow
//
//  Created by Dipika Bari on 08/05/2025.
//

import Foundation

enum LogLevel: String {
    case debug = "🐞 DEBUG"
    case info = "ℹ️ INFO"
    case warning = "⚠️ WARNING"
    case error = "❌ ERROR"
}

struct Logger {
    static var isLoggingEnabled = true

    static func log(_ message: String,
                    level: LogLevel = .debug,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        guard isLoggingEnabled else { return }
        let filename = (file as NSString).lastPathComponent
        print("[\(level.rawValue)] \(filename):\(line) \(function) ➡️ \(message)")
    }
}
