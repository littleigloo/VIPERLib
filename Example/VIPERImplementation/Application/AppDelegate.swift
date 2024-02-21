//
//  AppDelegate.swift
//  VIPERImplementation
//
//  Created by Vitalis Girsas on 29/1/24.
//

import UIKit
// ...........
var appDelegate: AppDelegate { UIApplication.shared.delegate as! AppDelegate }
// ...........
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    var window: UIWindow?
    
    // MARK: - LIFECYCLE
    // ////////////////////////////////////
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Setup managers
        SetupConsole.setupManagers()
        // Set root controller
        Manager.Environment.setInitialWindows()
        // ...........
        return true
    }
}

