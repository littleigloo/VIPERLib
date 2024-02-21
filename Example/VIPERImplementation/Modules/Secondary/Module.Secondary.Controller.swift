//
//  Module.Secondary.Controller.swift
//  VIPERImplementation
//
//  Created by Vitalis on 29/01/2024.
//  Copyright © 2024 ND. All rights reserved.
//

import UIKit
import VIPERLib
// ...........
final class SecondaryController: Controller<SecondaryModule> {
    // ...........
    enum Action {
        case didRequestData
    }
    
    //  MARK: PROPERTIES
    // ////////////////////////////////////
    /// - Parameters:
    ///
    ///     - presenter: [Controller -> Presentrer] Interface.
    ///
    
    // MARK: - IBOUTLETS
    // ////////////////////////////////////
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    // MARK: - IBACTIONS
    // ////////////////////////////////////
    @IBAction func didCallButtonTap(_ sender: Any) {
        // Send Action to Presenter
        presenter?.didAction(.didRequestData)
    }
    
    // MARK: - LIFECYCLE
    // ////////////////////////////////////
    override func viewDidLoad() {
        // Inform Presenter about view loading
        presenter?.viewDidLoad()
    }
}

//                                      MARK: - PRESENTER -> CONTROLLER
//..............................................................................................
extension SecondaryController: SecondaryPresenterToControllerInterface {
    // ...........
    func display(_ data: SecondaryPresenter.Display) {
        // Handle data
        switch data {
        case .name(let name):
            nameLabel.text = "NAME: \(name)"
            // ...........
        case .userData(let data):
            dataLabel.text = data
        }
    }
}
