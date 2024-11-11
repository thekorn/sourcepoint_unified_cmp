//
//  Logging.swift
//  xandr_ios
//
//  Created by markus korn on 13.05.24.
//

import Foundation
import os.log

public class Logger {
  private static let subsystem = Bundle.main.bundleIdentifier ?? "unknown"
  private var category: String = "unknown"

  private static func log(logType: OSLogType, category: String, message: String) {
    os_log(
      "%{public}@",
      log: OSLog(subsystem: Logger.subsystem, category: category),
      type: logType,
      message
    )
  }

  init(category: String) {
    self.category = category
  }

  public func debug(message: String) {
    Logger.log(logType: OSLogType.debug, category: category, message: message)
  }

  public func error(message: String) {
    Logger.log(logType: OSLogType.error, category: category, message: message)
  }

  public func info(message: String) {
    Logger.log(logType: OSLogType.info, category: category, message: message)
  }
}

var logger = Logger(category: "SourcepointUnifiedCmpPlugin")
