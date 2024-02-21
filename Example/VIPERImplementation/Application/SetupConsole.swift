//
//  SetupConsole.swift
//  VIPERImplementation
//
//  Created by Vitalis Girsas on 29/1/24.
//

import Foundation
import VIPERLib
// ...........
class SetupConsole {
    // MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    static func setupManagers() {
        // Setup VIPERLib
        VIPER.setup(logAdapter: MyLogAdapter(), isPringingDebug: true, isPringingReleases: true)
        // Setup initial Module
        Manager.Environment.setup(withRootModule: .navigation([.main]))
    }
}
