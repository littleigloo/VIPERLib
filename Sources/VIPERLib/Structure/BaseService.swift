//
//  BaseService.swift
//  VIPER Implementation
//
//  Created by Vitalis on 13/03/2019.
//  Copyright © 2020 Neiron Digital. All rights reserved.
//

open class BaseService {
    //  MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
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
    }
    
    deinit {
        print("SERVICE DEINIT")
    }
}
