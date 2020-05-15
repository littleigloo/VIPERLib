//
//  Extension.UIViewContoller.swift
//  VIPER Implementation
//
//  Created by Vitalis on 13/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit
// ...........
extension UIViewController {
    // ...........
    func present(module: Module, isAnimated: Bool = true, completion: (() -> Void)? = nil) {
        let vc = module.getController()
        if let presentationSylable = (vc as? PresentationSylable) {
            presentationSylable.controllerPresentationStyle = .presented
        }
        present(vc, animated: isAnimated, completion: completion)
    }
    // ...........
    public var isModal: Bool {

        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    // ...........
    public func hideSuitably() {
        
        guard let vc = self as? PresentationSylable, let style = vc.controllerPresentationStyle else  {
            guard self.isModal else {
                navigationController?.popViewController(animated: true)
                return
            }
            dismiss(animated: true, completion: nil)
            return
        }
        
        switch style {
        case .presented:
            dismiss(animated: true, completion: nil)
            // ...........
        case .pushed(let pushStyle):
            switch pushStyle {
            case .default:
                navigationController?.popViewController(animated: true)
                // ...........
            case .fade:
                navigationController?.unfade()
            }
        }
    }
}
// ...........
extension UIViewController: ViewPresenter {}
