//
//  OpenVars.swift
//  UUKit
//
//  Created by uxiu.me on 2018/4/23.
//
import UIKit

public var IS_RELAUNCH_APP: Bool {
    get {
        return UserDefaults.AppStart.bool(forKey: .isRelaunch)
    }
}

public var IS_LOGGEDIN_APP: Bool {
    get {
        return UserDefaults.AppStart.bool(forKey: .isLoggedIn)
    }
}

public var MainVC: UIViewController {
    get {
        var vc = UIApplication.shared.windows[0].rootViewController!
        if let presented_vc = vc.presentedViewController {
            vc = presented_vc.presentedViewController!
        }
        if vc.isKind(of: UITabBarController.self) {
            let tab = vc as! UITabBarController
            if (tab.selectedViewController?.isKind(of: UINavigationController.self))! {
                let navc = tab.selectedViewController as! UINavigationController
                return navc.viewControllers.last!
            } else {
                return tab.selectedViewController!
            }
        } else if vc.isKind(of: UINavigationController.self) {
            let navc = vc as! UINavigationController
            return navc.viewControllers.last!
        } else {
            return vc
        }
    }
}
