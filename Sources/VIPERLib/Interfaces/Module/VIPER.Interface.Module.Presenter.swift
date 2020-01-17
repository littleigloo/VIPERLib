//
//  VIPER.Interface.Presenter.swift
//  VIPER Implementation
//
//  Created by Vitalis on 13/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

//                                      MARK: - INTERFACE
//..............................................................................................

public protocol PresenterInterface: ControllerToPresenterInterface {
    associatedtype Router
    associatedtype Interactor
    associatedtype Controller
    associatedtype Model
    associatedtype ModuleDelegate
    var controller: Controller { get }
    var interactor: Interactor { get }
    var router: Router { get }
    var model: Model { get }
    var moduleDelegate: ModuleDelegate? { get }
    init(controller: Controller, interactor: Interactor, router: Router, model: Model, moduleDelegate: ModuleDelegate?)
}

//                                      MARK: - IN/OUT TRANSITIONS
//..............................................................................................

public protocol ControllerToPresenterInterface: class {
    func viewDidLoad()
    func viewWillAppear(animated: Bool)
    func viewDidAppear(animated: Bool)
    func viewWillDisappear(animated: Bool)
    func viewDidDisappear(animated: Bool)
}
