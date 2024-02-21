//
//  Manager.Log.swift
//  VIPERImplementation
//
//  Created by Vitalis Girsas on 31/1/24.
//

import Foundation
import VIPERLib
// ...........
typealias Log = Manager.Log
// ...........
class LogManager {
    // MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    static func debug(message: String) {
        print("🔵: \(message)")
    }
    // ...........
    static func info(message: String) {
        print("🟢: \(message)")
    }
    // ...........
    static func warning(message: String) {
        print("🟡: \(message)")
    }
    // ...........
    static func error(message: String) {
        print("🔴: \(message)")
    }
}
//                                      MARK: - LogAdapter for VIPERLib
//..............................................................................................
struct MyLogAdapter: LogAdapter {
    func log(_ logType: VIPERLib.LogAdapterMessageType, _ message: String) {
        switch logType {
        case .debug:
            Log.debug(message: message)
            // ...........
        case .warning:
            Log.warning(message: message)
            // ...........
        case .error:
            Log.error(message: message)
            // ...........
        case .info:
            Log.info(message: message)
        }
    }
}
