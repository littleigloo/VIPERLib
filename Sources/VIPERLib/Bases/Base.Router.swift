//
//  Base.Router.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

import UIKit
import SafariServices
// ...........
open class Router: RouterInterface {
    // MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    private let id: String
    // ...........
    private unowned let controller: UIViewController
    // ...........
    private var navigationController: UINavigationController? {
        return controller.navigationController
    }
    
    // MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    public var controllerType: UIViewController.Type {
        type(of: controller)
    }
    
    //  MARK: - INITS
    // ////////////////////////////////////
    required public init(controller: UIViewController, id: String) {
        self.id = id
        self.controller = controller
    }
    
    //  MARK: - LIFECYCLE
    // ////////////////////////////////////
    deinit {
        PoolManager.add(element: .router, name: "\(Self.self)", id: id)
    }
    
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    
    //  MARK: - NAVIGATION
    public func getNavigationControllerLastControllerType() -> UIViewController.Type? {
        guard let vc = navigationController?.viewControllers.last else {
            log(.error, "VIPERLib: COULD NOT GET navigationController LAST")
            return nil
        }
        return type(of: vc)
    }
    // ...........
    public func getNavigationStackTypeList() -> [UIViewController.Type] {
        guard let vcList = navigationController?.viewControllers else {
            return []
        }
        return vcList.map({type(of: $0)})
    }
    
    //  MARK: - PRESENT
    public func present(module: ModuleProtocol, isAnimated: Bool = true, completion: (() -> Void)? = nil) {
        controller.present(module: module, isAnimated: isAnimated, completion: completion)
    }
    // ...........
    public func dismiss(isAnimated: Bool, completion: (() -> Void)? = nil )  {
        navigationController?.dismiss(animated: isAnimated, completion: completion)
    }
    
    //  MARK: - PUSH
    public func push(module: ModuleProtocol, isAnimated: Bool = true) {
        navigationController?.push(module: module, isAnimated: isAnimated)
    }
    // ...........
    public func push<T: UIViewController>(module: ModuleProtocol, removing types: [T.Type], isAnimated: Bool = true) {
        navigationController?.push(module: module, removing: types, isAnimated: isAnimated)
    }
    // ...........
    public func push<T: UIViewController>(module: ModuleProtocol, removingTill type: T.Type, isAnimated: Bool = true) {
        navigationController?.push(module: module, removingTill: type, isAnimated: isAnimated)
    }
    // ...........
    public func popModule(isAnimated: Bool = true) {
        navigationController?.popViewController(animated: isAnimated)
    }
    // ...........
    public func popModule<T: UIViewController>(to controllerType: T.Type, isAnimated: Bool = true) {
        navigationController?.pop(to: controllerType, isAnimated: isAnimated)
    }
    // ...........
    public func fadeTo(module: ModuleProtocol) {
        navigationController?.fadeTo(module: module)
    }
    // ...........
    public func fadeTo<T: UIViewController>(module: ModuleProtocol, removing types: [T.Type]) {
        navigationController?.fadeTo(module: module, removing: types)
    }
    // ...........
    public func fadeTo<T: UIViewController>(module: ModuleProtocol, removingTill type: T.Type) {
        navigationController?.fadeTo(module: module, removingTill: type)
    }
    // ...........
    public func unfade() {
        navigationController?.unfade()
    }
    // ...........
    public func unfade<T: UIViewController>(to type: T.Type) {
        navigationController?.unfade(to: type)
    }
    // ...........
    public func unfadeTo<T: UIViewController>(module: ModuleProtocol, removingTill type: T.Type, leaving leavingTypesList: [T.Type] = []) {
        navigationController?.unfadeTo(module: module, removingTill: type, leaving: leavingTypesList)
    }
    // ...........
    public func slideTo(module: ModuleProtocol) {
        navigationController?.slide(module: module)
    }
    // ...........
    public func unslide() {
        navigationController?.unslide()
    }
    // ...........
    public func release() {
        controller.release()
    }
    // ...........
    public func release<T: UIViewController>(to controllerType: T.Type) {
        controller.release(to: controllerType)
    }
    // ...........
    public func stack(_ stackAction: UINavigationController.StackAction, with modules: [ModuleProtocol], style: ControllerPresentationStyle.PushedStyle = .default, isAnimated: Bool = false) {
        navigationController?.stack(stackAction, with: modules, style: style, isAnimated: isAnimated)
    }
    
    //  MARK: - WINDOW
    public func newRoot(module: ModuleProtocol, isAnimated: Bool = true, completion: (() -> Void)? = nil) {
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
    
    // Open url inside Safari
    public func openSafari(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        controller.present(safariViewController, animated: true)
    }
}
