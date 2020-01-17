//
//  VIPER.Base.Unit.Presenter.swift
//  VIPER Implementation
//
//  Created by Vitalis on 10/1/20.
//  Copyright © 2020 Neiron Digital. All rights reserved.
//

open class UnitPresenter<Unit: UnitInterface>: UnitPresenterInterface {
    
    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    
    public var view: Unit.PresenterToViewInterface {
        return _view as! Unit.PresenterToViewInterface
    }
    
    // ...........
    
    public var unitDelegate: Unit.DelegateInterface? {
        return _unitDelegate as? Unit.DelegateInterface
    }
    
    // ...........
    
    private(set) public var model: Unit.ViewModel? {
        didSet {
            didModelUpdated()
        }
    }
    
    //  MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    
    private weak var _view: AnyObject?
    private weak var _unitDelegate: AnyObject?
    
    //  MARK: - INITS
    // ////////////////////////////////////
    
    required public init(view: Unit.PresenterToViewInterface, model: Unit.ViewModel?, unitDelegate: Unit.DelegateInterface?) {
        
        _view = view as AnyObject
        _unitDelegate = unitDelegate as AnyObject
        self.model = model
    }
    
    //  MARK: - LIFECYCLE
    // ////////////////////////////////////
    
    deinit {
        print("∟DEINIT UNIT PRESENTER:  \(Self.self)")
        print("===================================================\n")
    }
    
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    
    open func didModelUpdated() {
        // Override inside subclass
    }
}
