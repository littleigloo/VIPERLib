//
//  VIPER.Interface.Interactor.swift
//  VIPER Implementation
//
//  Created by Vitalis on 13/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit

// ...........

//                                      MARK: - INTERFACE
//..............................................................................................

public protocol InteractorInterface: PresenterToInteractorInterface {
    associatedtype Controller
    var viewPresenter: ViewPresenter { get }
    init(controller: Controller)
}

//                                      MARK: - IN/OUT TRANSITIONS
//..............................................................................................

public protocol PresenterToInteractorInterface: class {
}
