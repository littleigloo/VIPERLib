//
//  Manager.Module.swift
//  VIPERImplementation
//
//  Created by Vitalis Girsas on 29/1/24.
//

import UIKit
import VIPERLib
// ...........
enum Module: ModuleProtocol {
    // ...........
    case launch
    case navigation([Module])
    case main
    case secondary(SecondaryModel)
    
    // MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    func getController() -> UIViewController {
        switch self {
        case .launch:
            Manager.Environment.loadController(withId: "launchScreen", fromStoryboard: "LaunchScreen")
            // ...........
        case .navigation(let modules):
            navigationStack(with: modules).getController()
            // ...........
        case .main:
            MainModule.get(with: MainModule.Model())
            // ...........
        case .secondary(let model):
            SecondaryModule.get(with: model)
        }
    }
}
