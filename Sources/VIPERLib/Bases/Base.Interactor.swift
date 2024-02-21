//
//  Base.Interactor.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

import UIKit
// ...........
open class Interactor<Module: ModuleInterface>: InteractorInterface {
    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    private let id: String
    // ...........
    public var viewPresenter: ViewPresenter {
        return _controller as! ViewPresenter
    }
    
    //  MARK: - METHODS 🔰 PRIVATE
    // ///////////////////////////////////////////
    private unowned let _controller: Module.Controller
    
    //  MARK: - INITS
    // ////////////////////////////////////
    required public init(controller: Module.Controller, id: String) {
        self.id = id
        _controller = controller
    }
    
    //  MARK: - LIFECYCLE
    // ////////////////////////////////////
    deinit {
        PoolManager.add(element: .interactor, name: "\(Self.self)", id: id)
    }
}
