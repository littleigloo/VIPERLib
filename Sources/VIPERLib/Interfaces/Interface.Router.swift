//
//  Interface.Router.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

//                                      MARK: - INTERFACE
//..............................................................................................
public protocol RouterInterface: PresenterToRouterInterface {
    associatedtype Controller
    init(controller: Controller, id: String)
}

//                                      MARK: - IN/OUT TRANSITIONS
//..............................................................................................
public protocol PresenterToRouterInterface: AnyObject {
    // ✔️ NONE
}
