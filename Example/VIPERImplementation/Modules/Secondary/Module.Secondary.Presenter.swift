//
//  Module.Secondary.Presenter.swift
//  VIPERImplementation
//
//  Created by Vitalis on 29/01/2024.
//  Copyright © 2024 ND. All rights reserved.
//

import VIPERLib
// ...........
final class SecondaryPresenter: Presenter<SecondaryModule> {
    // ...........
    enum Display {
        case name(String)
        case userData(String)
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
    
}

//                                      MARK: - CONTROLLER -> PRESENTER
//..............................................................................................
extension SecondaryPresenter: SecondaryControllerToPresenterInterface {
    // ...........
    override func viewDidLoad() {
        // Tell Controller to display name
        controller.display(.name(model.name))
    }
    // ...........
    func didAction(_ action: SecondaryController.Action) {
        // Handle action
        switch action {
        case .didRequestData:
            // Ask Interactor for user data
            interactor.fetchUserData(name: model.name) { [weak self] response in
                // Tell Controller to display user data
                self?.controller.display(.userData(response.data))
            }
        }
    }
}

//                                      MARK: - INPUT
//..............................................................................................
extension SecondaryPresenter: SecondaryInputInterface {
    // ✔️ NONE
}

