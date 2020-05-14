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
    public func present(module: Module, isAnimated: Bool = true, completion: (() -> Void)? = nil) {
        controller.present(module: module, isAnimated: isAnimated, completion: completion)
    }
    // ...........
    
    public func dismiss(isAnimated: Bool, completion: (() -> Void)? = nil )  {
        navigationController?.dismiss(animated: isAnimated, completion: completion)
    }

    // Push
    public func push(module: Module, isAnimated: Bool = true) {
        navigationController?.push(module: module, isAnimated: isAnimated)
    }
    // ...........
    
    public func popModule(isAnimated: Bool = true) {
        navigationController?.popViewController(animated: isAnimated)
    }
    
    // Window
    public func newRoot(module: Module, isAnimated: Bool = true, completion: (() -> Void)? = nil) {
        // Get main window
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        // Set the new rootViewController of the window
        // Calling "UIView.transition" below will animate the swap
        window.rootViewController = module.getController()
        // Check if animation needed
        guard isAnimated else {
            completion?()
            return
        }
        // A mask of options indicating how you want to perform the animations
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        // The duration of the transition animation, measured in seconds
        let duration: TimeInterval = 0.3
        // Create a transition animation
        UIView.transition(with: window, duration: duration, options: options, animations: {}) { _ in
            completion?()
        }
    }
}
