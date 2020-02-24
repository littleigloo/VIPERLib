//
//  Protocols.swift
//  VIPER Implementation
//
//  Created by Vit Gir on 17/02/19.
//  Copyright © 2020 Neiron Digital. All rights reserved.
//

import UIKit

// ...........

protocol Prepresentative {
    func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
}

