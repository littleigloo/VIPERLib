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
    enum GoBackStyle {
        case pop
        case unfade
    }
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
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
    
    // Pop to controller
    func pop<T: UIViewController>(to controllerType: T.Type) {
        goBack(to: controllerType, style: .pop)
    }
    
    // Unfate to controller
    func unfade<T: UIViewController>(to controllerType: T.Type) {
        goBack(to: controllerType, style: .unfade)
    }
    
    // Controllers stack
    func stack(with modules: [Module], style: ControllerPresentationStyle.PushedStyle = .default, isAnimated: Bool = false) {
        // Check modules
        guard !modules.isEmpty else {
            print("EMPTY MODULES LIST")
            return
        }
        // Declare controllers
        var controllersList = [UIViewController]()
        // Iterate
        modules.forEach { module in
            let vc = module.getController()
            if let presentationSylable = (vc as? PresentationSylable) {
                presentationSylable.controllerPresentationStyle = .pushed(style)
            }
            controllersList.append(vc)
        }
        // Check presentation style
        switch style {
        case .default:
            setViewControllers(controllersList, animated: isAnimated)
            // ...........
        case .fade:
            if isAnimated {
                let transition: CATransition = CATransition()
                transition.duration = 0.15
                transition.type = CATransitionType.fade
                view.layer.add(transition, forKey: nil)
            }
            setViewControllers(controllersList, animated: false)
        }
    }
    
    //  MARK: - METHODS 🔰 PRIVATE
    // ////////////////////////////////////
    private func goBack<T: UIViewController>(to controllerType: T.Type, style: GoBackStyle) {
        for vc in viewControllers {
            if vc.isKind(of: controllerType) {
                switch style {
                case .pop:
                    popToViewController(vc, animated: true)
                case .unfade:
                    popToViewController(vc, animated: false)
                }
                return
            }
        }
        print("COULD NOT GO BACK TO '\(controllerType.self)' CONTROLLERS")
    }
}
// ...........

extension UINavigationController: Module {
    public func getController() -> UIViewController {
        self
    }
}
