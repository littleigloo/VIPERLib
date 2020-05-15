//
//  Extension.UINavigationController.swift
//  VIPER Implementation
//
//  Created by Vitalis on 13/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit
// ...........

public extension UINavigationController {
    // ...........
    func push(module: Module, isAnimated: Bool = true) {
        let vc = module.getController()
        if let presentationSylable = (vc as? PresentationSylable) {
            presentationSylable.controllerPresentationStyle = .pushed(.default)
        }
        pushViewController(vc, animated: isAnimated)
    }
    // ...........
    func fadeTo(module: Module) {
        let vc = module.getController()
        if let presentationSylable = (vc as? PresentationSylable) {
            presentationSylable.controllerPresentationStyle = .pushed(.fade)
        }
        let transition: CATransition = CATransition()
        transition.duration = 0.15
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(vc, animated: false)
    }
    // ...........
    func unfade() {
        let transition: CATransition = CATransition()
        transition.duration = 0.15
        transition.timingFunction = CAMediaTimingFunction(name: .easeOut)
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        popViewController(animated: false)
    }
}
// ...........

extension UINavigationController: Module {
    public func getController() -> UIViewController {
        self
    }
}
