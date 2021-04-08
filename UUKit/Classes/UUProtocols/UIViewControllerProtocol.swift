////
////  UIViewControllerProtocol.swift
////  Pods
////
////  Created by uxiu.me on 2019/1/16.
////
//
//import UIKit
//
//protocol UIViewControllerProtocol {
//    
//    var navigationBarButtonItemLeft:  UIButton? { get }
//    var navigationBarRightItem: UIBarButtonItem? { get }
//    
//}
//
//protocol UITableViewControllerProtocol {
//    
//}
//
//protocol UISearchViewControllerProtocol {
//    
//}
//
//protocol UICollectionViewControllerProtocol {
//    
//}
//
//extension UIViewControllerProtocol where Self: UIViewController {
//    
//    var navigationBarButtonItemLeft: UIView? {
//        get {
//            return navigationController?.navigationItem.leftBarButtonItem?.customView
//        }
//    }
//    
//    var navigationBarRightItem: UIBarButtonItem? {
//        get {
//            return navigationController?.navigationItem.rightBarButtonItem
//        }
//        set {
//            navigationController?.navigationItem.rightBarButtonItem = newValue
//        }
//    }
//    
//}
//
//typealias ViewControllerProtocol = UIViewControllerProtocol & UITableViewControllerProtocol & UISearchViewControllerProtocol & UICollectionViewControllerProtocol
//
//
//struct UIViewControllerConfiguration {
//    
//    var navigationBarLeftItem: UIBarButtonItem?
//    var navigationBarRightItem: UIBarButtonItem?
//    var isStatusBarHidden = false
//    var statusBarStyle: UIStatusBarStyle = .default
//    var isNavigationBarHidden: Bool
//    
//}
//
//extension UIViewController {
//    
//    class Base {
//        
//        
//    }
//    
//    class Search {
//        
//    }
//    
//    class TableView {
//        
//        
//    }
//    
//    class CollectionView {
//        
//    }
//    
//}
//
//extension UIViewController {
//    
//    private struct AssociatedKeys {
//        static var DescriptiveName = "nsh_DescriptiveName"
//        static var name = UnsafeRawPointer(bitPattern: Int(bitPattern: "name"))
//    }
//    
//    var descriptiveName: String? {
//        get {
//            let key = UnsafeRawPointer(&AssociatedKeys.DescriptiveName)
//            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
//        }
//        set {
//            if let newValue = newValue {
//                objc_setAssociatedObject(self, &AssociatedKeys.DescriptiveName, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//            }
//        }
//    }
//}
//
//
