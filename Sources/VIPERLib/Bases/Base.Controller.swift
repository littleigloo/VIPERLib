//
//  Base.Controller.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

import UIKit
// ...........
open class Controller<Module: ModuleInterface>: UIViewController, 
                                                ControllerInterface,
                                                PresentationSylable,
                                                Identifiable,
                                                UITextFieldDelegate,
                                                UIGestureRecognizerDelegate {
    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    public var id: String!
    // ...........
    private(set) public var presenter: Module.ControllerToPresenterInterface!
    // ...........
    public var controllerPresentationStyle: ControllerPresentationStyle?
    
    //  MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    private var temporaryRootView: UIView?
    // ...........
    private var isPresenterSet = false
    private var isViewSet = false
    // ...........
    private var dismissControllsTapRecognizer: UITapGestureRecognizer?
    
    //  MARK: - LIFECYCLE
    // ////////////////////////////////////
    override public func loadView() {
        defer { temporaryRootView = nil }
        
        guard let temporaryRootView = temporaryRootView else {
            log(.error, "VIPERLib: NO temporaryRootView")
            return
        }
        view = temporaryRootView
    }
    // ...........
    deinit {
        PoolManager.add(element: .controller, name: "\(Self.self)", id: id)
    }
    
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    public func assign(id: String) {
        self.id = id
    }
    // ...........
    public func bind(withView view: UIView) {
        guard !isViewSet else {
            log(.warning, "VIPERLib: VIEW IS A GET ONLY")
            return
        }
        temporaryRootView = view
        isViewSet = true
    }
    // ...........
    public func bind(withPresenter presenter: Module.ControllerToPresenterInterface) {
        guard !isPresenterSet else {
            log(.warning, "VIPERLib: PRESENTER IS A GET ONLY")
            return
        }
        isPresenterSet = true
        self.presenter = presenter
        assignTextFields()
    }
    
    //                                      MARK: - TEXTS
    //..............................................................................................
    open func provideTextFields() -> [UITextField] {
        []
    }
    // ...........
    fileprivate func assignTextFields() {
        // Get text fields
        let textFields = provideTextFields()
        guard !textFields.isEmpty else {
            return
        }
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
    @objc func dismissControlls() {
        view.endEditing(true)
    }
    // ...........
    private func endEditing() {
        dismissControlls()
        disableDismissControllsTapRecognizer()
    }
    // ...........
    private func disableDismissControllsTapRecognizer() {
        dismissControllsTapRecognizer?.isEnabled = false
    }
    // ...........
    private func enableDismissControllsTapRecognizer() {
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
