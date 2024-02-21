//
//  Manager.Network.swift
//  VIPERImplementation
//
//  Created by Vitalis Girsas on 31/1/24.
//

import Foundation
// ...........
class NetworkManager {
    // ...........
    enum RequestCase {
        case userData(Request.UserData)
    }
    // ...........
    static func request(_ requestCase: RequestCase, onComplete: @escaping (String) -> ()) {
        let parameters: String
        // ...........
        switch requestCase {
        case .userData(let userDataRequest):
            parameters = userDataRequest.name
        }
        // ...........
        send(requestCase, parameters: parameters, onComplete: onComplete)
    }
    // ...........
    static func send(_ requestCase: RequestCase, parameters: String, onComplete: @escaping (String) -> ()) {
        Log.debug(message: "SERVICE REQUEST")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            Log.debug(message: "SERVICE RESPONSE")
            switch requestCase {
            case .userData(_):
                onComplete("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")
            }
        }
    }
}
// ...........
struct Service {
    // ✔️ NONE
}
// ...........
struct Request {
    // ✔️ NONE
}
// ...........
struct Response {
    // ✔️ NONE
}
