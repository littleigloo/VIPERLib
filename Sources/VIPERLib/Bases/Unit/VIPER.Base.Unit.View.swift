//
//  VIPER.Base.View.swift
//  VIPER Implementation
//
//  Created by Vitalis on 16/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit

// ...........

open class View<Unit: UnitInterface>: UIView, ViewInterface {

    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    
    public var presenter: Unit.ViewToPresenterInterface {
        return _presenter as! Unit.ViewToPresenterInterface
    }
    
    // ...........
    
    private(set) public var model: Unit.ViewModel? {
        didSet {
            
            // Check model
            guard let model = model else { print("NO MODEL"); return }
            didSet(model: model)
        }
    }
    
    //  MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    
    private var _presenter: AnyObject!
    
    // ...........
    
    private var isPresenterSet = false
    
    //  MARK: LIFECYCLE
    // ////////////////////////////////////
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        didAwake(with: model)
    }
    
    // ...........
    
    deinit {
        print("∟DEINIT UNIT VIEW:       \(Self.self)")
    }
    
    //  MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    
    public func bind(with presenter: Unit.ViewToPresenterInterface) {
        
        guard !isPresenterSet else {
            print("Presenter is get only")
            return
        }
        
        _presenter = presenter as AnyObject
        isPresenterSet = true
    }
    
    // ...........
    
    public func set(model: Unit.ViewModel) {
        self.model = model
    }
    
    // ...........
    
    open func didAwake(with model: Unit.ViewModel?) {
        // Override inside subclass
    }
    
    // ...........
    
    open func didSet(model: Unit.ViewModel) {
        // Override inside subclass
    }
    
    // ...........
    
    open func provideTextFields() -> [UITextField] {
        return []
    }
}
