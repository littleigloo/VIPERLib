//
//  Base.Service.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

open class Services {
    //  MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    private let id: String
    // ...........
    private weak var _viewPresenter: ViewPresenter?
    
    //  MARK: - PROPERTIES 🌐 PUBLIC
    // ////////////////////////////////////
    public var viewPresenter: ViewPresenter {
        return _viewPresenter!
    }
    
    //  MARK: - INITS
    // ////////////////////////////////////
    public init(with viewPresenter: ViewPresenter) {
        _viewPresenter = viewPresenter
        guard let viewPresenter = viewPresenter as? Identifiable else {
            fatalError()
        }
        id = viewPresenter.id
        PoolManager.registerServiceCreation(withId: id)
    }
    
    // MARK: - LIFECYCLE
    // ////////////////////////////////////
    deinit {
        PoolManager.add(element: .services, name: "\(Self.self)", id: id)
    }
}
