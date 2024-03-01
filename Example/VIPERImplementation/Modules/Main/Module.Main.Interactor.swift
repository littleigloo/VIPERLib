//
//  Module.Main.Interactor.swift
//  VIPERImplementation
//
//  Created by Vitalis on 29/01/2024.
//  Copyright © 2024 ND. All rights reserved.
//

import VIPERLib
// ...........
final class MainInteractor: Interactor<MainModule> {
    //  MARK: PROPERTIES
    // ////////////////////////////////////
    /// - Parameters:
    ///
    ///     - viewPresenter: ViewPresenter
    ///

    //  MARK: PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    fileprivate lazy var service = {
        MainServices(with: viewPresenter)
    }()
}

//                                      MARK: - SERVICES
//..............................................................................................
extension MainInteractor {
    fileprivate class MainServices: Services {
        // ...........
        // lazy var service = Services.GetData()
        // ...........
        // func fetchData(onComplete: @escaping (Services.GetData.Result) -> ()) {
        //     service.fetch(with: viewPresenter, onComplete)
        // }
    }
}

//                                      MARK: - PRESENTER -> INTERACTOR
//..............................................................................................
extension MainInteractor: MainPresenterToInteractorInterface {
    // ✔️ NONE
}
