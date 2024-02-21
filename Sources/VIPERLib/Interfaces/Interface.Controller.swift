//
//  Interface.Controller.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

import UIKit
//                                      MARK: - INTERFACE
//..............................................................................................
public protocol ControllerInterface: PresenterToControllerInterface {
    associatedtype Presenter
    var presenter: Presenter! { get }
    func assign(id: String)
    func bind(withPresenter presenter: Presenter)
    func bind(withView view: UIView)
    func provideTextFields() -> [UITextField]
    init()
}

//                                      MARK: - IN/OUT TRANSITIONS
//..............................................................................................
public protocol PresenterToControllerInterface: AnyObject {
    // ✔️ NONE
}
