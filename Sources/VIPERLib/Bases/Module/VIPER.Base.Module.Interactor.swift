//
//  VIPER.Base.Interactor.swift
//  VIPER Implementation
//
//  Created by Vitalis on 12/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit

// ...........

open class Interactor<Module: ModuleInterface>: InteractorInterface {
    
    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    
    public var viewPresenter: ViewPresenter {
        return _controller as! ViewPresenter
    }
    
    //  MARK: - METHODS 🔰 PRIVATE
    // ///////////////////////////////////////////

    private unowned let _controller: Module.Controller
    
    //  MARK: - INITS
    // ////////////////////////////////////
    
    required public init(controller: Module.Controller) {
        _controller = controller
    }
    
    //  MARK: - LIFECYCLE
    // ////////////////////////////////////
    
    deinit {
        print("DEINIT INTERACTOR: \(Self.self)")
    }
}
