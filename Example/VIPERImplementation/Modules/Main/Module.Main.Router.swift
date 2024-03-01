//
//  Module.Main.Router.swift
//  VIPERImplementation
//
//  Created by Vitalis on 29/01/2024.
//  Copyright © 2024 ND. All rights reserved.
//

import VIPERLib
// ...........
final class MainRouter: Router {
    // ...........
    enum Destination {
        case secondary(name: String)
    }
}

//                                      MARK: - PRESENTER -> ROUTER
//..............................................................................................

extension MainRouter: MainPresenterToRouterInterface {
    // ...........
    func navigateTo( _ destination: MainRouter.Destination) {
        // Handle destination
        switch destination {
        case .secondary(let name):
            //Create Socandary Module Model
            let model = SecondaryModel(name: name)
            // Move to Socandary Module
            push(module: Manager.Modules.secondary(model))
        }
    }
}
