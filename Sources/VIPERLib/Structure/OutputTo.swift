//
//  Output.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

import Foundation
// ...........
public protocol InOutBinderProtocol: AnyObject {
    associatedtype T
    var send: T? { get }
    var bind: ((T) -> ())? { get set }
}
// ...........
final public class OutputTo<T>: InOutBinderProtocol {
    //  MARK: PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    public var send: T? {
        return _input as? T
    }
    // ...........
    public lazy var bind: ((T) -> ())? = { [weak self] inputInterface in
        self?._input = inputInterface as AnyObject
    }
    // ...........
    public func unbind() {
        _input = nil
    }
    
    //  MARK: PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    private weak var _input: AnyObject?
    
    //  MARK: - INITS
    // ////////////////////////////////////
    public init() {
        // ✔️ NONE
    }
}
