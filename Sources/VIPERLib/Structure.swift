//
//  Structure.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

import UIKit
// ...........
public enum ControllerPresentationStyle {
    // ...........
    case presented
    case pushed(PushedStyle)
    // ...........
    public enum PushedStyle {
        case `default`
        case fade
        case slide
    }
}
// ...........
public class VIPER {
    // ...........
    internal static var logAdapter: LogAdapter = BaseAdapter()
    internal static var isPringingDebug = false
    internal static var isPringingReleases = true
    // ...........
    public static func setup(logAdapter: LogAdapter? = nil,
                             isPringingDebug: Bool? = nil,
                             isPringingReleases: Bool? = nil) {
        
        if let logAdapter = logAdapter {
            self.logAdapter = logAdapter
        }
        if let isPringingDebug = isPringingDebug {
            self.isPringingDebug = isPringingDebug
        }
        if let isPringingReleases = isPringingReleases {
            self.isPringingReleases = isPringingReleases
        }
    }
}
// ...........
protocol Identifiable {
    var id: String! { get }
}
// ...........
public protocol ModuleProtocol {
    func getController() -> UIViewController
}
// ...........
public protocol ViewPresenter: AnyObject {
    func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
}
// ...........
public protocol PresentationSylable: UIViewController {
    var controllerPresentationStyle: ControllerPresentationStyle? { get set }
}
// ...........
public func navigationStack(with modules: [ModuleProtocol], isBarHidden: Bool = false) -> ModuleProtocol {
    let navigation = UINavigationController()
    navigation.navigationBar.isHidden = isBarHidden
    navigation.interactivePopGestureRecognizer?.isEnabled = !isBarHidden
    navigation.stack(.new, with: modules)
    return navigation
}
