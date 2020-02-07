//
//  VIPER.Base.Controller.swift
//  VIPER Implementation
//
//  Created by Vitalis on 12/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit

// ...........

open class Controller<Module: ModuleInterface>: UIViewController, ControllerInterface {
    
    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////

    private(set) public var presenter: Module.ControllerToPresenterInterface?
    
    // ...........
    
    private weak var _presenter: Module.Presenter? {
        return presenter as? Module.Presenter
    }
    
    // ...........
    
    public var rootUnit: OutputTo<Module.Unit.InputInterface>?
    
    //  MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////

    private var temporaryRootView: Module.Unit.View?
    
    // ...........
    
    private var isPresenterSet      = false
    private var isViewSet           = false
    private var isUnitPresenterSet  = false

    //  MARK: - LIFECYCLE
    // ////////////////////////////////////
    
    override public func loadView() {
        defer { temporaryRootView = nil }
        
        guard let temporaryRootView = temporaryRootView else {
            print("NO temporaryRootView")
            return
        }

        view = temporaryRootView
        
        guard let presenter = _presenter else {
            print("NO PRESENTER")
            return
        }
        
        guard let presenterModel = presenter.model else {
            return
        }
        
        guard let viewModel = viewModel(from: presenterModel) else {
            print("NO VIEW MODEL PROVIDED INSIDE CONTROLLER.")
            return
        }
        
        temporaryRootView.set(model: viewModel)
    }
    
    // ...........
    
    deinit {
        print("\n===================================================")
        print("DEINIT CONTROLLER: \(Self.self)")
    }
    
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    
    public func bind(withView view: Module.Unit.View) {
        
        guard !isViewSet else {
            print("View is a get only")
            return
        }
        
        temporaryRootView = view
        isViewSet = true
    }
    
    // ...........
    
    public func bind(withPresenter presenter: Module.ControllerToPresenterInterface) {
        
        guard !isPresenterSet else {
            print("Presenter is a get only")
            return
        }
        
        self.presenter = presenter
        isPresenterSet = true
    }
    
    // ...........
    
    public func bind(withUnit viewInterface: OutputTo<Module.Unit.InputInterface>) {

        guard !isUnitPresenterSet else {
            print("View is a get only")
            return
        }
        
        rootUnit = viewInterface
        isUnitPresenterSet = true
    }
    
    // ...........
    
    open func viewModel(from model: Module.Model) -> Module.Unit.ViewModel? {
        // Override inside subclass
        return nil
    }
}
