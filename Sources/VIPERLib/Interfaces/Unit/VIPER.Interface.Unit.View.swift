//
//  VIPER.Interface.View.swift
//  VIPER Implementation
//
//  Created by Vitalis on 16/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

//                                      MARK: - INTERFACE
//..............................................................................................

public protocol ViewInterface: ControllerToViewInterface {
    associatedtype Presenter
    associatedtype Model
    var presenter: Presenter { get }
    var model: Model? { get }
    func bind(with presenter: Presenter)
}

//                                      MARK: - IN/OUT TRANSITIONS
//..............................................................................................

public protocol ControllerToViewInterface: class {
    associatedtype Model
    func set(model: Model)
}
