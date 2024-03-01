//
//  Base.Presenter.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

import Foundation
// ...........
open class Presenter<Module: ModuleInterface>: PresenterInterface {
    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    private let id: String
    // ...........
    public var moduleDelegate: Module.DelegateInterface? {
        return _moduleDelegate as? Module.DelegateInterface
    }
    // ...........
    public var controller: Module.PresenterToControllerInterface {
        return _controller as! Module.PresenterToControllerInterface
    }
    // ...........
    public var viewPresenter: ViewPresenter {
        return _controller as! ViewPresenter
    }
    // ...........
    public let interactor: Module.PresenterToInteractorInterface
    public let router:  Module.PresenterToRouterInterface
    // ...........
    private(set) public var model: Module.Model
    
    //  MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    private unowned let _controller: AnyObject
    private unowned let _moduleDelegate: AnyObject
    
    //  MARK: - INITS
    // ////////////////////////////////////
    required public init(controller: Module.PresenterToControllerInterface,
                         interactor: Module.PresenterToInteractorInterface,
                         router: Module.PresenterToRouterInterface,
                         model: Module.Model,
                         moduleDelegate: Module.DelegateInterface?,
                         id: String) {
        
        self.id = id
        _controller = controller as AnyObject
        self.interactor = interactor
        self.router = router
        self.model = model
        _moduleDelegate = moduleDelegate as AnyObject
    }
    
    //  MARK: - LIFECYCLE
    // ////////////////////////////////////
    deinit {
        PoolManager.add(element: .presenter, name: "\(Self.self)", id: id)
    }
    
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    @objc
    dynamic
    open func viewDidLoad() {
        log(.error, "VIPERLib: IMPLEMENTATION PENDING: viewDidLoad")
        fatalError()
    }
    // ...........
    @objc
    dynamic
    open func viewWillAppear(animated: Bool) {
        log(.error, "VIPERLib: IMPLEMENTATION PENDING: viewWillAppear")
        fatalError()
    }
    // ...........
    @objc
    dynamic
    open func viewDidAppear(animated: Bool) {
        log(.error, "VIPERLib: IMPLEMENTATION PENDING: viewDidAppear")
        fatalError()
    }
    // ...........
    @objc
    dynamic
    open func viewWillDisappear(animated: Bool) {
        log(.error, "VIPERLib: IMPLEMENTATION PENDING: viewWillDisappear")
        fatalError()
    }
    // ...........
    @objc
    dynamic 
    open func viewDidDisappear(animated: Bool) {
        log(.error, "VIPERLib: IMPLEMENTATION PENDING: viewDidDisappear")
        fatalError()
    }
}
