//
//  Log.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

import Foundation
//                                      MARK: - PUBLIC
//..............................................................................................
public enum LogAdapterMessageType {
    case debug
    case info
    case warning
    case error
}
// ...........
public protocol LogAdapter {
    func log(_ logType: LogAdapterMessageType, _ message: String)
}
//                                      MARK: - INTERNAL
//..............................................................................................
internal func log(_ logType: LogAdapterMessageType, _ message: String) {
    VIPER.logAdapter.log(logType, message)
}
// ...........
internal class BaseAdapter: LogAdapter {
    // ...........
    func log(_ logType: LogAdapterMessageType, _ message: String) {
        print(message)
    }
}
