//
//  UUTabBarController.swift
//  UUKit
//
//  Created by 夏军辉 on 2021/5/27.
//

import UIKit

class UUTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.frame = UIScreen.main.bounds
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return selectedViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return selectedViewController
    }
    
    override var childForHomeIndicatorAutoHidden: UIViewController? {
        return selectedViewController
    }
    
    override var childForScreenEdgesDeferringSystemGestures: UIViewController? {
        return selectedViewController
    }
    
    override var shouldAutorotate: Bool {
        return selectedViewController?.shouldAutorotate ?? false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return selectedViewController?.supportedInterfaceOrientations ?? .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return selectedViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
    
    deinit { print("deinit:\t\(classForCoder)") }

}
