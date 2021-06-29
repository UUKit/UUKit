//
//  UUViewController.swift
//  Pods-UUKit_Example
//
//  Created by uxiu.me on 2019/6/20.
//

import UIKit

extension UIViewController {
    
    enum ViewType {
        case `default`
        case tableView
        case collectionView
    }
    
    struct AssociatedKey {
        // StatusBar
        static var statusBarStyle = UnsafeRawPointer(bitPattern: "StatusBarStyle".hashValue)!
        static var isStatusBarHidden = UnsafeRawPointer(bitPattern: "IsStatusBarHidden".hashValue)!
        
        // NavigationBar
        static var isNavigationBarHidden = UnsafeRawPointer(bitPattern: "IsNavigationBarHidden".hashValue)!
        static var leftNavigationBarItem = UnsafeRawPointer(bitPattern: "LeftNavigationBarItem".hashValue)!
        static var rightNavigationBarItem = UnsafeRawPointer(bitPattern: "RightNavigationBarItem".hashValue)!
        
        // SearchBar
        static var searchViewControllerKey = UnsafeRawPointer(bitPattern: "SearchViewController".hashValue)!
        
        
    }
    
    
}

extension UIViewController {

//    var descriptiveName: String? {
//        get {
//            let key = UnsafeRawPointer(&AssociatedKeys.DescriptiveName)
//            
//            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
//        }
//        set {
//            if let newValue = newValue {
//                objc_setAssociatedObject(self, &AssociatedKeys.DescriptiveName, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//            }
//        }
//    }
}

class UUViewController<Container: UIView>: UIViewController {
    
    var container: Container { view as! Container }
    
    override func loadView() {
        super.loadView()
        if view is Container { return }
        view = Container()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    deinit { print("deinit:\t\(classForCoder)") }
    
}
