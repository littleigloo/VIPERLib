//
//  Extension.UIViewContoller.swift
//  VIPER Implementation
//
//  Created by Vitalis on 13/12/2019.
//  Copyright © 2019 Neiron Digital. All rights reserved.
//

import UIKit
// ...........
extension UIViewController {
    func present(module: Module, isAnimated: Bool = true, completion: (() -> Void)? = nil) {
        present(module.getController(), animated: isAnimated, completion: completion)
    }
}
// ...........
extension UIViewController: ViewPresenter {}
