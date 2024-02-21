//
//  Module.Secondary.Interactor.swift
//  VIPERImplementation
//
//  Created by Vitalis on 29/01/2024.
//  Copyright © 2024 ND. All rights reserved.
//

import VIPERLib
// ...........
final class SecondaryInteractor: Interactor<SecondaryModule> {
    //  MARK: PROPERTIES
    // ////////////////////////////////////
    /// - Parameters:
    ///
    ///     - viewPresenter: ViewPresenter
    ///

    //  MARK: PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    fileprivate lazy var service = {
        SecondaryServices(with: viewPresenter)
    }()
}

//                                      MARK: - SERVICES
//..............................................................................................
extension SecondaryInteractor {
    fileprivate class SecondaryServices: Services {
        // ...........
        lazy var userData = Service.GetUserData()
    }
}

//                                      MARK: - PRESENTER -> INTERACTOR
//..............................................................................................
extension SecondaryInteractor: SecondaryPresenterToInteractorInterface {
    // ...........
    func fetchUserData(name: String, onComplete: @escaping (Response.UserData) -> ()) {
        let request = Request.UserData(name: name)
        service.userData.request(request, onComplete: onComplete)
    }
}
