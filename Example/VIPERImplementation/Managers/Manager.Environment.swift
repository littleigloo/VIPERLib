//
//  Manager.Environment.swift
//  VIPERImplementation
//
//  Created by Vitalis Girsas on 29/1/24.
//

import UIKit
// ...........
class EnvironmentManager {
    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    private(set) static var rootModule: Module?
    
    //  MARK: - SETUPS
    // ////////////////////////////////////
    static func setup(withRootModule rootModule: Module) {
        self.rootModule = rootModule
    }
    
    //  MARK: METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    static func setInitialWindows() {
        // Get root module
        guard let rootModule = rootModule else {
            Log.error(message: "NO ROOT MODULE SET")
            return
        }
        // Init app with root window and unity window
        setWindow(with: rootModule)
    }
    // ...........
    static func setWindow(with module: Module, afterVisible: ((UIViewController) -> ())? = nil) {
        // Create window
        let window = UIWindow(frame: UIScreen.main.bounds)
        // Assign to appDelegate
        appDelegate.window = window
        // Window properties
        window.backgroundColor = UIColor.white
        // Set controller
        let controller = module.getController()
        window.rootViewController = controller
        // Make visible
        window.makeKeyAndVisible()
        // Execute after make visible commands
        afterVisible?(controller)
    }
    // ...........
    static func loadController(withId id: String, fromStoryboard storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        return vc
    }
}
