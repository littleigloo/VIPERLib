//
//  VIPER.Base.Presenter.swift
//  VIPER Implementation
//
//  Created by Vitalis on 12/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import Foundation

// ...........

open class Presenter<Module: ModuleInterface>: PresenterInterface {

    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    
    public var moduleDelegate: Module.DelegateInterface? {
        return _moduleDelegate as? Module.DelegateInterface
    }
    // ...........
    
    public var controller: Module.PresenterToControllerInterface {
        return _controller as! Module.PresenterToControllerInterface
    }
    
    // ...........

    public let interactor:     Module.PresenterToInteractorInterface
    public let router:         Module.PresenterToRouterInterface

    // ...........
    
    private(set) public var model: Module.Model? {
        didSet {
            didModelUpdated()
        }
    }
    
    //  MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    
    private unowned let _controller: AnyObject
    private unowned let _moduleDelegate: AnyObject
    
    //  MARK: - INITS
    // ////////////////////////////////////
    
    required public init(controller: Module.PresenterToControllerInterface,
                  interactor: Module.PresenterToInteractorInterface,
                  router: Module.PresenterToRouterInterface,
                  model: Module.Model?,
                  moduleDelegate: Module.DelegateInterface?) {
        
        _controller = controller as AnyObject
        self.interactor = interactor
        self.router = router
        self.model = model
        _moduleDelegate = moduleDelegate as AnyObject
    }
    
    //  MARK: - LIFECYCLE
    // ////////////////////////////////////
    
    deinit {
        print("DEINIT PRESENTER:  \(Self.self)")
    }
    
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    
    @objc
    dynamic
    open func viewDidLoad() {
        fatalError("Implementation pending...")
    }
    
    // ...........

    @objc
    dynamic
    open func viewWillAppear(animated: Bool) {
        fatalError("Implementation pending...")
    }
    
    // ...........

    @objc
    dynamic
    open func viewDidAppear(animated: Bool) {
        fatalError("Implementation pending...")
    }
    
    // ...........

    @objc
    dynamic
    open func viewWillDisappear(animated: Bool) {
        fatalError("Implementation pending...")
    }
    
    // ...........

    @objc
    dynamic 
    open func viewDidDisappear(animated: Bool) {
        fatalError("Implementation pending...")
    }
    
    // ...........
    
    func updateModel(with newModel: Module.Model) {
        model = newModel
    }
    
    // ...........
    
    open func didModelUpdated() {
        // Override inside subclass
    }
}
