//
//  Extension+UIViewContoller.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

import UIKit
// ...........
extension UIViewController {
    // ...........
    func present(module: ModuleProtocol, isAnimated: Bool = true, completion: (() -> Void)? = nil) {
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
    public func release() {
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
                // ...........
            case .slide:
                navigationController?.unslide()
            }
        }
    }
    // ...........
    public func release<T: UIViewController>(to controllerType: T.Type) {
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
                navigationController?.pop(to: controllerType)
                // ...........
            case .fade:
                navigationController?.unfade(to: controllerType)
                // ...........
            case .slide:
                navigationController?.unslide(to: controllerType)
            }
        }
    }
    // ...........
    @discardableResult
    public func add(_ child: UIViewController, destinationView: UIView? = nil) -> UIView {
        addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        let destinationView = destinationView ?? view!
        destinationView.addSubview(child.view)
        child.didMove(toParent: self)
        return child.view
    }
    // ...........
    public func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
// ...........
extension UIViewController: ViewPresenter {}
