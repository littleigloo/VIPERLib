//
//  VIPER.Base.Router.swift
//  VIPER Implementation
//
//  Created by Vitalis on 12/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit

// ...........

open class Router: RouterInterface {
    
    //  MARK: - METHODS 🔰 PRIVATE
    // ///////////////////////////////////////////

    private unowned let controller: UIViewController
    
    // ...........
    
    private var navigationController: UINavigationController? {
        return controller.navigationController
    }
    
    //  MARK: - INITS
    // ////////////////////////////////////
    
    required public init(controller: UIViewController) {
        self.controller = controller
    }
    
    //  MARK: - LIFECYCLE
    // ////////////////////////////////////
    
    deinit {
        print("DEINIT ROUTER:     \(Self.self)")
    }
    
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    
    // Present
    
    func present(module: Module, animated: Bool = true, completion: (() -> Void)? = nil) {
        controller.present(module: module, animated: animated, completion: completion)
    }
    
    // ...........
    
    func dismiss(animated: Bool, completion: (() -> Void)? = nil )  {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
    
    // Push
    
    func push(module: Module, animated: Bool = true) {
        navigationController?.push(module: module, animated: animated)
    }
    
    // ...........
    
    func popModule(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
}
