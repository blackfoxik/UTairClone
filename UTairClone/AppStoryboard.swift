//
//  AppStoryboard.swift
//  UTairClone
//
//  Created by Anton on 25.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard: String {
    case Main
    case MyTickets
    case SignUp
    case Purchase
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController> (viewControllerClass: T.Type) -> T? {
        return self.instance.instantiateViewController(withIdentifier: viewControllerClass.storyboardID) as? T
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
    
}

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiateFromAppStoryboard(appStoryboard: AppStoryboard) -> Self? {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
