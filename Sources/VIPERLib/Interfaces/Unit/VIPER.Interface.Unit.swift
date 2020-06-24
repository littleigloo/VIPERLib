//
//  VIPER.Interface.Unit.swift
//  VIPER Implementation
//
//  Created by Vit Gir on 29/12/19.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit
import NibTools

//                                      MARK: - INTERFACE
//..............................................................................................

public protocol UnitInterface {
    // MODEL
    associatedtype ViewModel
    // MAIN
    associatedtype Presenter: UnitPresenterInterface
    associatedtype View: ViewInterface where View: UIView, ViewModel == View.Model
    
    // //////////   INTERFACES
    // /////////////////////////////////////
    
    // IN/OUT
    associatedtype InputInterface
    associatedtype DelegateInterface
    
    // PRESENTER -> VIEW
    associatedtype PresenterToViewInterface
    // VIEW -> PRESENTER
    associatedtype ViewToPresenterInterface
}

//  MARK: -

public extension UnitInterface {
    
    // ...........
    
    typealias InputBinder = OutputTo<InputInterface>
    
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    
    static func get(with viewModel: ViewModel? = nil, unitDelegate delegate: DelegateInterface? = nil, connectTo unitInput: InputBinder? = nil) -> View {
        // Create VIEW.
        let view = View.fromNib()
        
        // Prepare PRESENTER'S VIEW.
        guard let presenterView = view as? Presenter.View else {
            fatalError("UNIT VIEW DOES NOT CONFORM TO: \(Presenter.View.self)")
        }
        
        // Prepare PRESENTER'S VIEW MODEL.
        
        var presenterViewModel: Presenter.ViewModel?
        
        // Check PRESENTER'S VIEW MODEL.
        if let viewModel = viewModel {
            
            // PRESENTER'S VIEW MODEL.
            guard let model = viewModel as? Presenter.ViewModel else {
                fatalError("UNIT VIEW MODEL DOES NOT CONFORM TO: \(Presenter.ViewModel.self)")
            }
            presenterViewModel = model
        }
        
        // Prepare PRESENTER'S DELEGATE.
        
        var presenterDelegate: Presenter.UnitDelegate?
        
        // Check PRESENTER'S DELEGATE.
        if let delegate = delegate {
            
            // PRESENTER'S DELEGATE.
            guard let delegate = delegate as? Presenter.UnitDelegate else {
                fatalError("UNIT DELEGATE DOES NOT CONFORM TO: \(Presenter.UnitDelegate.self)")
            }
            presenterDelegate = delegate
        }

        // Create PRESESNTER from VIEW, VIEWMODEL and UNIT DELEGATE.
        let presenter = Presenter(view: presenterView, model: presenterViewModel, unitDelegate: presenterDelegate)
        
        // Prepare VIEW'S PRESENTER.
        guard let viewPresenter = presenter as? View.Presenter else {
            fatalError("UNIT PRESENTER DOES NOT CONFORM TO: \(View.Presenter.self)")
        }
    
        // Bind PRESENTER to the VIEW.
        view.bind(with: viewPresenter)
        
        // Prepare UNIT'S INPUT.
        
        // Check UNIT'S INPUT.
        if let input = unitInput {
            
            // PRESENTER'S INPUT.
            guard let presenterInput = presenter as? InputInterface else {
                fatalError("UNIT PRESENTER DOES NOT CONFORM TO: \(InputInterface.self)")
            }
            
            // Bind UNIT'S INPUT to the PRESENTER'S INPUT.
            input.bind?(presenterInput)
        }
        
        // Return as VIEW.
        return view
    }
}
