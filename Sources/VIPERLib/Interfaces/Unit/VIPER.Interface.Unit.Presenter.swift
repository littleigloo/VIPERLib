//
//  VIPER.Interface.Unit.Presenter.swift
//  VIPER Implementation
//
//  Created by Vitalis on 10/1/20.
//  Copyright © 2020 Neiron Digital. All rights reserved.
//

//                                      MARK: - INTERFACE
//..............................................................................................

public protocol UnitPresenterInterface: ViewToPresenterInterface {
    associatedtype View
    associatedtype ViewModel
    associatedtype UnitDelegate
    var view: View { get }
    var model: ViewModel? { get }
    var unitDelegate: UnitDelegate? { get }
    init(view: View, model: ViewModel?, unitDelegate: UnitDelegate?)
}

//                                      MARK: - IN/OUT TRANSITIONS
//..............................................................................................

public protocol ViewToPresenterInterface: class {
}
