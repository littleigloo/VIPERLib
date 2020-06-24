//
//  VIPER.Base.Controller.swift
//  VIPER Implementation
//
//  Created by Vitalis on 12/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit

// ...........

open class Controller<Module: ModuleInterface>: UIViewController, ControllerInterface, UITextFieldDelegate, UIGestureRecognizerDelegate, PresentationSylable {
    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    private(set) public var presenter: Module.ControllerToPresenterInterface?
    // ...........
    private weak var _presenter: Module.Presenter? {
        return presenter as? Module.Presenter
    }
    // ...........
    public var rootUnit: OutputTo<Module.Unit.InputInterface>?
    // ...........
    public var controllerPresentationStyle: ControllerPresentationStyle?
    
    //  MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    private var temporaryRootView: Module.Unit.View?
    // ...........
    private var isPresenterSet      = false
    private var isViewSet           = false
    private var isUnitPresenterSet  = false
    // ...........
    private var dismissControllsTapRecognizer: UITapGestureRecognizer?

    //  MARK: - LIFECYCLE
    // ////////////////////////////////////
    
    override public func loadView() {
        defer { temporaryRootView = nil }
        
        guard let temporaryRootView = temporaryRootView else {
            print("NO temporaryRootView")
            return
        }

        view = temporaryRootView
        
        guard let presenter = _presenter else {
            print("NO PRESENTER")
            return
        }
        
        guard let presenterModel = presenter.model else {
            return
        }
        
        didSet(model: presenterModel)
        
        guard let viewModel = viewModel(from: presenterModel) else {
            return
        }
        
        temporaryRootView.set(model: viewModel)
    }
    
    // ...........
    
    deinit {
        print("\n===================================================")
        print("DEINIT CONTROLLER: \(Self.self)")
    }
    
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    
    public func bind(withView view: Module.Unit.View) {
        
        guard !isViewSet else {
            print("View is a get only")
            return
        }
        
        temporaryRootView = view
        isViewSet = true
    }
    
    // ...........
    
    public func bind(withPresenter presenter: Module.ControllerToPresenterInterface) {
        
        guard !isPresenterSet else {
            print("Presenter is a get only")
            return
        }
        
        self.presenter = presenter
        isPresenterSet = true
    }
    
    // ...........
    
    public func bind(withUnit viewInterface: OutputTo<Module.Unit.InputInterface>) {

        guard !isUnitPresenterSet else {
            print("View is a get only")
            return
        }
        
        rootUnit = viewInterface
        isUnitPresenterSet = true
    }
    
    // ...........
    
    public func assignTextFields(_ textFields: [UITextField]) {
        // Create recognizer
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissControlls))
        recognizer.cancelsTouchesInView = false
        recognizer.isEnabled = false
        recognizer.delegate = self
        dismissControllsTapRecognizer = recognizer
        view.addGestureRecognizer(recognizer)
        // Set delegates
        textFields.forEach({$0.delegate = self})
    }
    // ...........
    
    open func didSet(model: Module.Model) {
        // Override inside subclass
    }
    // ...........
    
    open func viewModel(from model: Module.Model) -> Module.Unit.ViewModel? {
        // Override inside subclass
        return nil
    }
    
    // ...........
    @objc func dismissControlls() {
        view.endEditing(true)
    }
    // ...........
    fileprivate func endEditing() {
        dismissControlls()
        disableDismissControllsTapRecognizer()
    }
    // ...........
    fileprivate func disableDismissControllsTapRecognizer() {
        dismissControllsTapRecognizer?.isEnabled = false
    }
    // ...........
    fileprivate func enableDismissControllsTapRecognizer() {
        dismissControllsTapRecognizer?.isEnabled = true
    }
    // ...........
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing()
        return true
    }
    // ...........
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        enableDismissControllsTapRecognizer()
        if let delegate = view as? UITextFieldDelegate {
            delegate.textFieldDidBeginEditing?(textField)
        }
    }
    // ...........
    public func textFieldDidEndEditing(_ textField: UITextField) {
        endEditing()
        if let delegate = view as? UITextFieldDelegate {
            delegate.textFieldDidEndEditing?(textField)
        }
    }
    // ...........
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let delegate = view as? UIGestureRecognizerDelegate,
            let value = delegate.gestureRecognizer?(gestureRecognizer, shouldReceive: touch) else {
            return true
        }
        return value
    }
}
