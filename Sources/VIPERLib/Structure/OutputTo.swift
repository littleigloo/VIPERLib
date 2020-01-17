//
//  Output.swift
//  VIPER Implementation
//
//  Created by Vit Gir on 21/12/19.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import Foundation

// ...........

public protocol InOutBinderProtocol: class {
    associatedtype T
    var send: T? { get }
    var bind: ((T) -> ())? { get set }
}

// ...........

public class OutputTo<T>: InOutBinderProtocol {
    
    //  MARK: PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    
    public var send: T? {
        return _input as? T
    }
    
    // ...........
    
    public lazy var bind: ((T) -> ())? = { [weak self] inputInterface in
        self?._input = inputInterface as AnyObject
    }
    
    //  MARK: PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    
    private weak var _input: AnyObject?
}
