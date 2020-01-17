//
//  Extension.UINavigationController.swift
//  VIPER Implementation
//
//  Created by Vitalis on 13/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit

// ...........

public extension UINavigationController {
    
    func push(module: Module, animated: Bool = true) {
        pushViewController(module.getController(), animated: animated)
    }
    
    // ...........
    
    func setRootModule(_ module: Module, animated: Bool = true) {
        setViewControllers([module.getController()], animated: animated)
    }
}
