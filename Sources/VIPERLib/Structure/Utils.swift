//
//  Utils.swift
//  VIPER Implementation
//
//  Created by Vitalis on 23/05/20.
//  Copyright © 2020 Neiron Digital. All rights reserved.
//

import UIKit

//                                      MARK: - GLOBAL
//..............................................................................................
public func newRoot(module: Module, isAnimated: Bool = true, completion: (() -> Void)? = nil) {
    Utils.newRoot(module: module, isAnimated: isAnimated, completion: completion)
}

//                                      MARK: - UTILS
//..............................................................................................
class Utils {
    //  MARK: - METHODS 🔄 INTERNAL
    // ///////////////////////////////////////////
    static func newRoot(module: Module, isAnimated: Bool = true, completion: (() -> Void)? = nil) {
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
