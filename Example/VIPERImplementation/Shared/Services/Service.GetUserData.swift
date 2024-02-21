//
//  Service.GetUserData.swift
//  VIPERImplementation
//
//  Created by Vitalis Girsas on 31/1/24.
//

import Foundation
// ...........
extension Service {
    // ...........
    struct GetUserData {
        func request(_ request: Request.UserData, onComplete: @escaping (Response.UserData) -> ()) {
            Manager.Network.request(.userData(request)) { response in
                onComplete(Response.UserData(name: request.name, data: response))
            }
        }
    }
}
