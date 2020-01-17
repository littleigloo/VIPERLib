//
//  VIPER.Base.Interactor.swift
//  VIPER Implementation
//
//  Created by Vitalis on 12/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

open class Interactor: InteractorInterface {
    
    //  MARK: - INITS
    // ////////////////////////////////////
    
    required public init() {}
    
    //  MARK: - LIFECYCLE
    // ////////////////////////////////////
    
    deinit {
        print("DEINIT INTERACTOR: \(Self.self)")
    }
}
