//
//  VIPER.Base.Router.swift
//  VIPER Implementation
//
//  Created by Vitalis on 12/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit
import SafariServices
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
    public func getNavigationControllerLastControllerType() -> UIViewController.Type? {
        guard let vc = navigationController?.viewControllers.last else {
            print("COULD NOT GET navigationController LAST")
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
    
    public func push<T: UIViewController>(module: Module, removing types: [T.Type], isAnimated: Bool = true) {
        navigationController?.push(module: module, removing: types, isAnimated: isAnimated)
    }
    // ...........
    
    public func push<T: UIViewController>(module: Module, removingTill type: T.Type, isAnimated: Bool = true) {
        navigationController?.push(module: module, removingTill: type, isAnimated: isAnimated)
    }
    // ...........
    
    public func popModule(isAnimated: Bool = true) {
        navigationController?.popViewController(animated: isAnimated)
    }
    // ...........
    
    public func fadeTo(module: Module) {
        navigationController?.fadeTo(module: module)
    }
    // ...........
    
    public func fadeTo<T: UIViewController>(module: Module, removing types: [T.Type]) {
        navigationController?.fadeTo(module: module, removing: types)
    }
    // ...........
    
    public func fadeTo<T: UIViewController>(module: Module, removingTill type: T.Type) {
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
    
    public func unfadeTo<T: UIViewController>(module: Module, removingTill type: T.Type, leaving leavingTypesList: [T.Type] = []) {
        navigationController?.unfadeTo(module: module, removingTill: type, leaving: leavingTypesList)
    }
    // ...........
    
    public func slideTo(module: Module) {
        navigationController?.slide(module: module)
    }
    // ...........
    
    public func unslide() {
        navigationController?.unslide()
    }
    // ...........
    
    public func hideSuitably() {
        controller.hideSuitably()
    }
    // ...........

    public func hideSuitably<T: UIViewController>(to controllerType: T.Type) {
        controller.hideSuitably(to: controllerType)
    }
    // ...........
    
    public func stack(_ stackAction: UINavigationController.StackAction, with modules: [Module], style: ControllerPresentationStyle.PushedStyle = .default, isAnimated: Bool = false) {
        navigationController?.stack(stackAction, with: modules, style: style, isAnimated: isAnimated)
    }
    
    // Window
    public func newRoot(module: Module, isAnimated: Bool = true, completion: (() -> Void)? = nil) {
        Utils.newRoot(module: module, isAnimated: isAnimated, completion: completion)
    }
    
    // Open url inside Safari
    public func openSafari(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        controller.present(safariViewController, animated: true)
    }
}
