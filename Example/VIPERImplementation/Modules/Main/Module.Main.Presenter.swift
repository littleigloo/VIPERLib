//
//  Module.Main.Presenter.swift
//  VIPERImplementation
//
//  Created by Vitalis on 29/01/2024.
//  Copyright © 2024 ND. All rights reserved.
//

import VIPERLib
// ...........
final class MainPresenter: Presenter<MainModule> {
    // ...........
    enum Display {
        // ✔️ NONE
        case none
    }
    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    /// - Parameters:
    ///
    ///     - model:            Model.
    ///     - moduleDelegate:   [Presentrer -> Module Delegate] Interface.
    ///
    ///     - controller:       [Presentrer -> Controller] Interface.
    ///     - interactor:       [Presentrer -> Interactor] Interface.
    ///     - router:           [Presentrer -> Router] Interface.
    ///
    ///     - viewPresenter:    ViewPresenter
    ///
    
    // MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    private let isUserLogged = true
    
    // MARK: - METHODS 🔰 PRIVATE
    // ////////////////////////////////////
    private func getSelectedName() -> String? {
        guard isUserLogged else {
            Log.warning(message: "USER IS NOT LOGGED")
            return nil
        }
        return "John Doe"
    }
}

//                                      MARK: - CONTROLLER -> PRESENTER
//..............................................................................................
extension MainPresenter: MainControllerToPresenterInterface {
    // ...........
    func didAction(_ action: MainController.Action) {
        // Handle Controller's Action
        switch action {
        case .goNext:
            guard let name = getSelectedName() else {
                return
            }
            // Tell Router to navigate to Secondary Module
            router.navigateTo(.secondary(name: name))
        }
    }
}

//                                      MARK: - INPUT
//..............................................................................................
extension MainPresenter: MainInputInterface {
    // ✔️ NONE
}
