//
//  Interface.Module.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

import UIKit
//                                      MARK: - INTERFACE
//..............................................................................................
public protocol ModuleInterface {
    // MODEL
    associatedtype Model
    // MAIN
    associatedtype Controller: ControllerInterface
    associatedtype Presenter: PresenterInterface where Presenter.Model == Model
    associatedtype Interactor: InteractorInterface
    associatedtype Router: RouterInterface
    // ...........
    static var nibName: String { get }
    // //////////   INTERFACES
    // /////////////////////////////////////
    // IN/OUT
    associatedtype InputInterface
    associatedtype DelegateInterface
    // CONTROLLER -> PRESENTER
    associatedtype ControllerToPresenterInterface
    // PRESENTER -> CONTROLLER
    associatedtype PresenterToControllerInterface
    // PRESENTER -> INTERACTOR
    associatedtype PresenterToInteractorInterface
    // PRESENTER -> ROUTER
    associatedtype PresenterToRouterInterface
}

//                                      MARK: - IMPLEMENTATION
//..............................................................................................
public extension ModuleInterface {
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    static func get(with model: Model,
                    moduleDelegate delegate: DelegateInterface? = nil,
                    connectTo moduleInput: OutputTo<InputInterface>? = nil) -> UIViewController {
        // Create id
        let id = UUID().uuidString
        // Create CONTROLLER.
        let controller = Controller()
        controller.assign(id: id)
        // Prepare INTERACTORS'S CONTROLLER.
        guard let interactorController = controller as? Interactor.Controller else {
            log(.error, "VIPERLib: MODULE CONTROLLER DOES NOT CONFORM TO: \(Interactor.Controller.self)")
            fatalError()
        }
        // Create INTERACTOR.
        let interactor = Interactor(controller: interactorController, id: id)
        // Prepare ROUTER'S CONTROLLER.
        guard let routerController = controller as? Router.Controller else {
            log(.error, "VIPERLib: MODULE CONTROLLER DOES NOT CONFORM TO: \(Router.Controller.self)")
            fatalError()
        }
        // Create ROUTER with CONTROLLER.
        let router = Router(controller: routerController, id: id)
        // Prepare PRESENTER'S CONTROLLER.
        guard let preesenterController = controller as? Presenter.Controller else {
            log(.error, "VIPERLib: MODULE CONTROLLER DOES NOT CONFORM TO: \(Presenter.Controller.self)")
            fatalError()
        }
        // Prepare PRESENTER'S INTERACTOR.
        guard let preesenterInteractor = interactor as? Presenter.Interactor else {
            log(.error, "VIPERLib: MODULE INTERACTOR DOES NOT CONFORM TO: \(Presenter.Interactor.self)")
            fatalError()
        }
        // Prepare PRESENTER'S ROUTER.
        guard let preesenterRouter = router as? Presenter.Router else {
            log(.error, "VIPERLib: MODULE ROUTER DOES NOT CONFORM TO: \(Presenter.Router.self)")
            fatalError()
        }
        // Prepare PRESENTER'S DELEGATE.
        var presenterDelegate: Presenter.ModuleDelegate?
        // Check PRESENTER'S DELEGATE.
        if let delegate = delegate {
            // PRESENTER'S DELEGATE.
            guard let delegate = delegate as? Presenter.ModuleDelegate else {
                log(.error, "VIPERLib: MODULE DELEGATE DOES NOT CONFORM TO: \(Presenter.ModuleDelegate.self)")
                fatalError()
            }
            presenterDelegate = delegate
        }
        // Create PRESENTER from CONTROLLER, INTERACTOR, ROUTER, MODEL and MODULE DELEGATE.
        let presenter = Presenter(controller: preesenterController,
                                  interactor: preesenterInteractor,
                                  router: preesenterRouter,
                                  model: model,
                                  moduleDelegate: presenterDelegate,
                                  id: id)
        // Prepare CONTROLLER'S PRESENTER.
        guard let controllerPresenter = presenter as? Controller.Presenter else {
            log(.error, "VIPERLib: MODULE PRESENTER DOES NOT CONFORM TO: \(Controller.Presenter.self)")
            fatalError()
        }
        // Bind PRESENTER to CONTROLLER.
        controller.bind(withPresenter: controllerPresenter)
        // Prepare CONTROLLER'S VIEW.
        guard let nib = Bundle.main.loadNibNamed(nibName, owner: controller, options: nil)?.first as? UIView else {
            log(.error, "VIPERLib: COULD NOT GET NIB 'nibName'")
            fatalError()
        }
        // Bind VIEW to CONTROLLER.
        controller.bind(withView: nib)
        // Check MODULE'S INPUT.
        if let input = moduleInput {
            // PRESENTER'S INPUT.
            guard let presenterInput = presenter as? InputInterface else {
                log(.error, "VIPERLib: MODULE PRESENTER DOES NOT CONFORM TO: \(InputInterface.self)")
                fatalError()
            }
            input.bind?(presenterInput)
        }
        // Check UIViewController.
        guard let viewController = controller as? UIViewController else {
            log(.error, "VIPERLib: CANNOT CAST CONTROLLER TO UIViewController")
            fatalError()
        }
        // Return as UIViewController.
        return viewController
    }
}
