//
//  Interface.Presenter.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

//                                      MARK: - INTERFACE
//..............................................................................................
public protocol PresenterInterface: ControllerToPresenterInterface {
    associatedtype Router
    associatedtype Interactor
    associatedtype Controller
    associatedtype Model
    associatedtype ModuleDelegate
    var controller: Controller { get }
    var interactor: Interactor { get }
    var router: Router { get }
    var model: Model { get }
    var moduleDelegate: ModuleDelegate? { get }
    init(controller: Controller,
         interactor: Interactor,
         router: Router,
         model: Model,
         moduleDelegate: ModuleDelegate?,
         id: String)
}

//                                      MARK: - IN/OUT TRANSITIONS
//..............................................................................................
public protocol ControllerToPresenterInterface: AnyObject {
    func viewDidLoad()
    func viewWillAppear(animated: Bool)
    func viewDidAppear(animated: Bool)
    func viewWillDisappear(animated: Bool)
    func viewDidDisappear(animated: Bool)
}
