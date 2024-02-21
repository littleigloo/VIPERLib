//
//  Module.Secondary.swift
//  VIPERImplementation
//
//  Created by Vitalis on 29/01/2024.
//  Copyright © 2024 ND. All rights reserved.
//

import VIPERLib

//                                      MARK: - MODEL
//.............................................................................................
struct SecondaryModel {
    let name: String
}

//                                      MARK: - MODULE IN/OUT
//.............................................................................................
// IN
protocol SecondaryInputInterface {
    // ✔️ NONE
}
// ...........
// OUT
protocol SecondaryDelegateInterface {
    // ✔️ NONE
}

//                                      MARK: - PRESENTER -> CONTROLLER
//.............................................................................................
protocol SecondaryPresenterToControllerInterface: PresenterToControllerInterface {
    func display(_ data: SecondaryPresenter.Display)
}

//                                      MARK: - CONTROLLER -> PRESENTER
//.............................................................................................
protocol SecondaryControllerToPresenterInterface: ControllerToPresenterInterface {
    func didAction(_ action: SecondaryController.Action)
}

//                                      MARK: - PRESENTER -> INTERACTOR
//.............................................................................................
protocol SecondaryPresenterToInteractorInterface: PresenterToInteractorInterface {
    func fetchUserData(name: String, onComplete: @escaping (Response.UserData) -> ())
}

//                                      MARK: - PRESENTER -> ROUTER
//.............................................................................................
protocol SecondaryPresenterToRouterInterface: PresenterToRouterInterface {
    func navigateTo(_ destination: SecondaryRouter.Destination)
}

//                                      MARK: - MODULE
//..............................................................................................
final class SecondaryModule: ModuleInterface {
    // NIB
    static var nibName: String { return "Module.Secondary" }
    // MODEL
    typealias Model = SecondaryModel
    // MAIN
    typealias Controller = SecondaryController
    typealias Presenter = SecondaryPresenter
    typealias Interactor = SecondaryInteractor
    typealias Router = SecondaryRouter
    // //////////   INTERFACES
    // /////////////////////////////////////
    // IN/OUT
    typealias InputInterface  = SecondaryInputInterface
    typealias DelegateInterface = SecondaryDelegateInterface
    // CONTROLLER
    typealias ControllerToPresenterInterface = SecondaryControllerToPresenterInterface
    // PRESENTER
    typealias PresenterToControllerInterface = SecondaryPresenterToControllerInterface
    typealias PresenterToInteractorInterface = SecondaryPresenterToInteractorInterface
    typealias PresenterToRouterInterface = SecondaryPresenterToRouterInterface
}
