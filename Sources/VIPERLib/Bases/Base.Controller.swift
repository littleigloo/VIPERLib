//
//  Base.Controller.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

import UIKit
// ...........
open class Controller<Module: ModuleInterface>: UIViewController, 
                                                ControllerInterface,
                                                PresentationSylable,
                                                Identifiable {
    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    public var id: String!
    // ...........
    private(set) public var presenter: Module.ControllerToPresenterInterface!
    // ...........
    public var controllerPresentationStyle: ControllerPresentationStyle?
    
    //  MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    private var temporaryRootView: UIView?
    // ...........
    private var isPresenterSet = false
    private var isViewSet = false
    
    //  MARK: - LIFECYCLE
    // ////////////////////////////////////
    override public func loadView() {
        defer { temporaryRootView = nil }
        
        guard let temporaryRootView = temporaryRootView else {
            log(.error, "VIPERLib: NO temporaryRootView")
            return
        }
        view = temporaryRootView
    }
    // ...........
    deinit {
        PoolManager.add(element: .controller, name: "\(Self.self)", id: id)
    }
    
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    public func assign(id: String) {
        self.id = id
    }
    // ...........
    public func bind(withView view: UIView) {
        guard !isViewSet else {
            log(.warning, "VIPERLib: VIEW IS A GET ONLY")
            return
        }
        temporaryRootView = view
        isViewSet = true
    }
    // ...........
    public func bind(withPresenter presenter: Module.ControllerToPresenterInterface) {
        guard !isPresenterSet else {
            log(.warning, "VIPERLib: PRESENTER IS A GET ONLY")
            return
        }
        isPresenterSet = true
        self.presenter = presenter
    }
}
