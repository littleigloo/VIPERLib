//
//  Interface.Interactor.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

import UIKit
//                                      MARK: - INTERFACE
//..............................................................................................
public protocol InteractorInterface: PresenterToInteractorInterface {
    associatedtype Controller
    var viewPresenter: ViewPresenter { get }
    init(controller: Controller, id: String)
}

//                                      MARK: - IN/OUT TRANSITIONS
//..............................................................................................
public protocol PresenterToInteractorInterface: AnyObject {
    // ✔️ NONE
}
