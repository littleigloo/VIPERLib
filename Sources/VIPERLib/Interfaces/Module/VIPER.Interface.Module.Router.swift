//
//  VIPER.Interface.Router.swift
//  VIPER Implementation
//
//  Created by Vitalis on 13/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

//                                      MARK: - INTERFACE
//..............................................................................................

public protocol RouterInterface: PresenterToRouterInterface {
    associatedtype Controller
    init(controller: Controller)
}

//                                      MARK: - IN/OUT TRANSITIONS
//..............................................................................................

public protocol PresenterToRouterInterface: class {
}
