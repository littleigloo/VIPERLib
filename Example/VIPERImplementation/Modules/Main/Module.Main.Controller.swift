//
//  Module.Main.Controller.swift
//  VIPERImplementation
//
//  Created by Vitalis on 29/01/2024.
//  Copyright © 2024 ND. All rights reserved.
//

import UIKit
import VIPERLib
// ...........
final class MainController: Controller<MainModule> {
    // ...........
    enum Action {
        case goNext
    }
    
    //  MARK: PROPERTIES
    // ////////////////////////////////////
    /// - Parameters:
    ///
    ///     - presenter: [Controller -> Presentrer] Interface.
    ///
    
    // MARK: - IBACTIONS
    // ////////////////////////////////////
    @IBAction func didNextButtonTap(_ sender: Any) {
        // Send Action to Presenter
        presenter?.didAction(.goNext)
    }
}

//                                      MARK: - PRESENTER -> CONTROLLER
//..............................................................................................
extension MainController: MainPresenterToControllerInterface {
    // ...........
    func display(_ data: MainPresenter.Display) {
        // ✔️ NONE
    }
}
