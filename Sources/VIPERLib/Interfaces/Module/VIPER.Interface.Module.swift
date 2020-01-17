//
//  Viper.Interface.Module.swift
//  VIPER Implementation
//
//  Created by Vit Gir on 12/12/19.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit

//                                      MARK: - INTERFACE
//..............................................................................................

public protocol ModuleInterface {
    // MODEL
    associatedtype Model
    // MAIN
    associatedtype Controller: ControllerInterface
    associatedtype Unit: UnitInterface
    associatedtype Presenter: PresenterInterface where Presenter.Model == Model
    associatedtype Interactor: InteractorInterface
    associatedtype Router: RouterInterface
    
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

//  MARK: -

public extension ModuleInterface {
    
    // ...........
    
    typealias InputBinder = OutputTo<InputInterface>
    
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    
    static func get(with model: Model, moduleDelegate delegate: DelegateInterface? = nil, connectTo moduleInput: InputBinder? = nil) -> UIViewController {
        return assemble(model: model, moduleDelegate: delegate, connectTo: moduleInput)
    }
    
    //  MARK: - METHODS 🔰 PRIVATE
    // ///////////////////////////////////////////

    private static func assemble(model: Model, moduleDelegate delegate: DelegateInterface?, connectTo moduleInput: InputBinder?) -> UIViewController {
        
        // Create UNIT'S INPUT interface.
        let unitInterface = OutputTo<Unit.InputInterface>()
        
        // Create CONTROLLER.
        let controller = Controller()
        
        // Prepare UNIT'S DELEGATE.
        guard let unitDelegate = controller as? Unit.DelegateInterface else {
            fatalError("MODULE CONTROLLER DOES NOT CONFORM TO: \(Unit.DelegateInterface.self)")
        }
        
        // Get VIEW from UNIT with UNIT DELEGATE and UNIT INPUT.
        let view = Unit.get(unitDelegate: unitDelegate, connectTo: unitInterface)
        
        // Create INTERACTOR.
        let interactor = Interactor()
        
        // Prepare ROUTER'S CONTROLLER.
        guard let routerController = controller as? Router.Controller else {
            fatalError("MODULE CONTROLLER DOES NOT CONFORM TO: \(Router.Controller.self)")
        }
        
        // Create ROUTER with CONTROLLER.
        let router = Router(controller: routerController)
        
        // Prepare PRESENTER'S CONTROLLER.
        guard let preesenterController = controller as? Presenter.Controller else {
            fatalError("MODULE CONTROLLER DOES NOT CONFORM TO: \(Presenter.Controller.self)")
        }
        
        // Prepare PRESENTER'S INTERACTOR.
        guard let preesenterInteractor = interactor as? Presenter.Interactor else {
            fatalError("MODULE INTERACTOR DOES NOT CONFORM TO: \(Presenter.Interactor.self)")
        }
        
        // Prepare PRESENTER'S ROUTER.
        guard let preesenterRouter = router as? Presenter.Router else {
            fatalError("MODULE ROUTER DOES NOT CONFORM TO: \(Presenter.Router.self)")
        }
        
        // Prepare PRESENTER'S DELEGATE.
        
        var presenterDelegate: Presenter.ModuleDelegate?
        
        // Check PRESENTER'S DELEGATE.
        if let delegate = delegate {
            
            // PRESENTER'S DELEGATE.
            guard let delegate = delegate as? Presenter.ModuleDelegate else {
                fatalError("MODULE DELEGATE DOES NOT CONFORM TO: \(Presenter.ModuleDelegate.self)")
            }
            presenterDelegate = delegate
        }
        
        // Create PRESENTER from CONTROLLER, INTERACTOR, ROUTER, MODEL and MODULE DELEGATE.
        let presenter = Presenter(controller: preesenterController,
                                  interactor: preesenterInteractor,
                                  router: preesenterRouter,
                                  model: model,
                                  moduleDelegate: presenterDelegate)
        
        // Prepare CONTROLLER'S PRESENTER.
        guard let controllerPresenter = presenter as? Controller.Presenter else {
            fatalError("MODULE PRESENTER DOES NOT CONFORM TO: \(Controller.Presenter.self)")
        }

        // Bind PRESENTER to CONTROLLER.
        controller.bind(withPresenter: controllerPresenter)
        
        // Prepare CONTROLLER'S VIEW.
        guard let controllerView = view as? Controller.View else {
            fatalError("MODULE VIEW DOES NOT CONFORM TO: \(Controller.View.self)")
        }
        
        // Bind VIEW to CONTROLLER.
        controller.bind(withView: controllerView)
        
        // Prepare CONTROLLER'S UNIT'S INPUT interface.
        guard let controllerUnitInterface = unitInterface as? OutputTo<Controller.UnitInterface> else {
            fatalError("MODULE UNIT DOES NOT CONFORM TO: \(OutputTo<Controller.UnitInterface>.self)")
        }
        
        // Bind UNIT to CONTROLLER.
        controller.bind(withUnit: controllerUnitInterface)
        
        // Check MODULE'S INPUT.
        if let input = moduleInput {
            
            // PRESENTER'S INPUT.
            guard let presenterInput = presenter as? InputInterface else {
                fatalError("MODULE PRESENTER DOES NOT CONFORM TO: \(InputInterface.self)")
            }
            input.bind?(presenterInput)
        }
        
        // Check UIViewController.
        guard let viewController = controller as? UIViewController else {
            fatalError("CANNOT CAST CONTROLLER TO UIViewController")
        }
        
        // Return as UIViewController.
        return viewController
    }
}
