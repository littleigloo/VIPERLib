//
//  Module.Main.swift
//  VIPERImplementation
//
//  Created by Vitalis on 29/01/2024.
//  Copyright © 2024 ND. All rights reserved.
//

import VIPERLib

//                                      MARK: - MODEL
//.............................................................................................
struct MainModel {
    // ✔️ NONE
}

//                                      MARK: - MODULE IN/OUT
//.............................................................................................
// IN
protocol MainInputInterface {
    // ✔️ NONE
}
// ...........
// OUT
protocol MainDelegateInterface {
    // ✔️ NONE
}

//                                      MARK: - PRESENTER -> CONTROLLER
//.............................................................................................
protocol MainPresenterToControllerInterface: PresenterToControllerInterface {
    func display(_ data: MainPresenter.Display)
}

//                                      MARK: - CONTROLLER -> PRESENTER
//.............................................................................................
protocol MainControllerToPresenterInterface: ControllerToPresenterInterface {
    func didAction(_ action: MainController.Action)
}

//                                      MARK: - PRESENTER -> INTERACTOR
//.............................................................................................
protocol MainPresenterToInteractorInterface: PresenterToInteractorInterface {
    // ✔️ NONE
}

//                                      MARK: - PRESENTER -> ROUTER
//.............................................................................................
protocol MainPresenterToRouterInterface: PresenterToRouterInterface {
    func navigateTo(_ destination: MainRouter.Destination)
}

//                                      MARK: - MODULE
//..............................................................................................
final class MainModule: ModuleInterface {
    // NIB
    static var nibName: String { return "Module.Main" }
    // MODEL
    typealias Model = MainModel
    // MAIN
    typealias Controller = MainController
    typealias Presenter = MainPresenter
    typealias Interactor = MainInteractor
    typealias Router = MainRouter
    // //////////   INTERFACES
    // /////////////////////////////////////
    // IN/OUT
    typealias InputInterface  = MainInputInterface
    typealias DelegateInterface = MainDelegateInterface
    // CONTROLLER
    typealias ControllerToPresenterInterface = MainControllerToPresenterInterface
    // PRESENTER
    typealias PresenterToControllerInterface = MainPresenterToControllerInterface
    typealias PresenterToInteractorInterface = MainPresenterToInteractorInterface
    typealias PresenterToRouterInterface = MainPresenterToRouterInterface
}
