//
//  VIPER.Interface.View.swift
//  VIPER Implementation
//
//  Created by Vitalis on 16/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit

//                                      MARK: - INTERFACE
//..............................................................................................

public protocol ViewInterface: PresenterToViewInterface {
    associatedtype Presenter
    associatedtype Model
    var presenter: Presenter { get }
    var model: Model? { get }
    func bind(with presenter: Presenter)
    func provideTextFields() -> [UITextField]
}

//                                      MARK: - IN/OUT TRANSITIONS
//..............................................................................................

public protocol PresenterToViewInterface: class {
    associatedtype Model
    func set(model: Model)
}
