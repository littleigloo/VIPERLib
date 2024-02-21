//
//  Module.Secondary.Router.swift
//  VIPERImplementation
//
//  Created by Vitalis on 29/01/2024.
//  Copyright © 2024 ND. All rights reserved.
//

import VIPERLib
// ...........
final class SecondaryRouter: Router {
    // ...........
    enum Destination {
        case none // ✔️ NONE
    }
}

//                                      MARK: - PRESENTER -> ROUTER
//..............................................................................................

extension SecondaryRouter: SecondaryPresenterToRouterInterface {
    // ...........
    func navigateTo( _ destination: SecondaryRouter.Destination) {
        // Handle destination
        switch destination {
        case .none: break // ✔️ NONE
        }
    }
}

