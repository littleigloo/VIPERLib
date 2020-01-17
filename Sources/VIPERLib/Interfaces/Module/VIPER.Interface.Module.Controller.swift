//
//  VIPER.Interface.Controller.swift
//  VIPER Implementation
//
//  Created by Vitalis on 13/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

//                                      MARK: - INTERFACE
//..............................................................................................

public protocol ControllerInterface: PresenterToControllerInterface, ViewToControllerInterface {
    associatedtype Presenter
    associatedtype UnitInterface
    associatedtype View
    var presenter: Presenter? { get }
    var rootUnit: OutputTo<UnitInterface>? { get }
    func bind(withPresenter presenter: Presenter)
    func bind(withView view: View)
    func bind(withUnit unitInterface: OutputTo<UnitInterface>)
    init()
}

//                                      MARK: - IN/OUT TRANSITIONS
//..............................................................................................

public protocol PresenterToControllerInterface: class {
}

// ...........

public protocol ViewToControllerInterface: class {
}
