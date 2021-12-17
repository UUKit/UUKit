//
//  UIViewControllerProtocol.swift
//  Pods
//
//  Created by uxiu.me on 2019/1/16.
//

import UIKit

public protocol NavigationItemProtocol {
    
    var leftItem: UIView? { get set }
    var titleItem: UIView? { get set }
    var rightItem: UIView? { get set }
    
    
}


protocol UIViewControllerProtocol {
    var leftBarImage: UIImage? { get set }
    var rightBarImage: UIImage? { get set }
    var backgroundImage: UIImage? { get set }
    var safeBackgroundImage: UIImage? { get set }
    
    var leftBarButton: UIButton? { get set }
    var rightBarButton: UIButton? { get set }
    var backgroundView: UIView? { get set }
    var safeBackgroundView: UIView? { get set }
}

protocol UITableViewControllerProtocol {
    
}

protocol UISearchViewControllerProtocol {
    
}

protocol UICollectionViewControllerProtocol {
    
}

extension UIViewControllerProtocol where Self: UIViewController {
    
    var navigationBarButtonItemLeft: UIView? {
        get {
            return navigationController?.navigationItem.leftBarButtonItem?.customView
        }
    }
    
    var navigationBarRightItem: UIBarButtonItem? {
        get {
            return navigationController?.navigationItem.rightBarButtonItem
        }
        set {
            navigationController?.navigationItem.rightBarButtonItem = newValue
        }
    }
    
}

typealias ViewControllerProtocol = UIViewControllerProtocol & UITableViewControllerProtocol & UISearchViewControllerProtocol & UICollectionViewControllerProtocol


struct UIViewControllerConfiguration {
    
    var navigationBarLeftItem: UIBarButtonItem?
    var navigationBarRightItem: UIBarButtonItem?
    var isStatusBarHidden = false
    var statusBarStyle: UIStatusBarStyle = .default
    var isNavigationBarHidden: Bool
    
}

extension UIViewController {
    
    class Base {
        
        
    }
    
    class Search {
        
    }
    
    class TableView {
        
        
    }
    
    class CollectionView {
        
    }
    
}

extension UIViewController {
    
    
}


//{
//    //
//    //  BaseNavigationController.swift
//    //  QuanYuLe
//    //
//    //  Created by donaldsong on 17-3-1.
//    //  Copyright © 2017 Tencent. All rights reserved.
//    //
//
//    import UIKit
//
//    class BaseNavigationController: UINavigationController {
//
//        /// A Boolean value indicating whether navigation controller is currently pushing a new view controller on the stack.
//        fileprivate(set) var isDuringPushAnimation = false
//
//        fileprivate(set) var appeared = false
//
//        /// A real delegate of the class. `delegate` property is used only for keeping an internal state during
//        /// animations – we need to know when the animation ended, and that info is available only
//        /// from `navigationController:didShowViewController:animated:`.
//        weak var outerDelegate: UINavigationControllerDelegate? = nil
//
//        deinit {
//            super.delegate = nil
//            outerDelegate = nil
//            interactivePopGestureRecognizer?.delegate = nil
//        }
//
//        override func viewDidLoad() {
//            print(self, #function)
//            super.viewDidLoad()
//            if nil == delegate {
//                super.delegate = self
//            }
//            interactivePopGestureRecognizer?.delegate = self
//        }
//
//        override func viewWillAppear(_ animated: Bool) {
//            print(self, #function, animated)
//            super.viewWillAppear(animated)
//        }
//        override func viewWillLayoutSubviews() {
//            print(self, #function)
//            super.viewWillLayoutSubviews()
//        }
//        override func viewDidLayoutSubviews() {
//            print(self, #function)
//            super.viewDidLayoutSubviews()
//        }
//        override func viewDidAppear(_ animated: Bool) {
//            print(self, #function, animated)
//            super.viewDidAppear(animated)
//            appeared = true
//        }
//        override func viewWillDisappear(_ animated: Bool) {
//            print(self, #function, animated)
//            super.viewWillDisappear(animated)
//        }
//        override func viewDidDisappear(_ animated: Bool) {
//            print(self, #function, animated)
//            super.viewDidDisappear(animated)
//            appeared = false
//        }
//
//
//        // MARK: - ChildViewController
//
//        override func addChildViewController(_ childController: UIViewController) {
//            print(self, #function, childController)
//            super.addChildViewController(childController)
//        }
//        override func removeFromParentViewController() {
//            print(self, #function)
//            super.removeFromParentViewController()
//        }
//
//        override func willMove(toParentViewController parent: UIViewController?) {
//            print(self, #function, String(describing: parent))
//            super.willMove(toParentViewController: parent)
//        }
//        override func didMove(toParentViewController parent: UIViewController?) {
//            print(self, #function, String(describing: parent))
//            super.didMove(toParentViewController: parent)
//        }
//
//
//        // MARK: - Navigation
//
//        override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//            print(self, #function, identifier, String(describing: sender))
//            return super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
//        }
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            print(self, #function, segue.destination, String(describing: sender))
//            super.prepare(for: segue, sender: sender)
//        }
//        override func performSegue(withIdentifier identifier: String, sender: Any?) {
//            print(self, #function, identifier, String(describing: sender))
//            super.performSegue(withIdentifier: identifier, sender: sender)
//        }
//
//        // MARK: - Target-Action
//
//        override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//            print(self, #function, action, String(describing: sender))
//            return super.canPerformAction(action, withSender: sender)
//        }
//        override func target(forAction action: Selector, withSender sender: Any?) -> Any? {
//            let t = super.target(forAction: action, withSender: sender)
//            print(self, #function, action, String(describing: sender), "result is:", String(describing: t))
//            return t
//        }
//        override func targetViewController(forAction action: Selector, sender: Any?) -> UIViewController? {
//            let vc = super.targetViewController(forAction: action, sender: sender)
//            print(self, #function, action, String(describing: sender), "result is:", String(describing: vc))
//            return vc
//        }
//
//        // MARK: - misc
//
//        override var delegate: UINavigationControllerDelegate? {
//            get {
//                return super.delegate
//            }
//            set {
//                assert(newValue === self, "delegate must be the navigationController itself; use outerDelegate instead.")
//                super.delegate = newValue
//            }
//        }
//
//        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//            print(self, #function, viewController, animated)
//            guard !isDuringPushAnimation else {
//                print("push被阻止：push动画未结束又开始了新的push")
//                return
//            }
//            isDuringPushAnimation = animated
//            if viewControllers.count > 0 {
//                viewController.hidesBottomBarWhenPushed = true // 业务需要
//            }
//            super.pushViewController(viewController, animated: animated)
//        }
//
//        override func popViewController(animated: Bool) -> UIViewController? {
//            print(self, #function, String(describing: topViewController), animated)
//            return super.popViewController(animated: animated)
//        }
//        override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
//            print(self, #function, viewController, viewControllers, animated)
//            return super.popToViewController(viewController, animated: animated)
//        }
//        override func popToRootViewController(animated: Bool) -> [UIViewController]? {
//            print(self, #function, viewControllers, animated)
//            return super.popToRootViewController(animated: animated)
//        }
//
//        weak var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
//    }
//
//
//    // MARK: - UINavigationControllerDelegate
//
//    extension BaseNavigationController: UINavigationControllerDelegate {
//
//        func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//            print(self, #function, viewController, animated)
//            // push 或 pop 到 viewController 过程，本方法调用都在 viewController 的 viewWillAppear() 之后，viewWillLayoutSubviews() 之前
//            outerDelegate?.navigationController?(navigationController, willShow: viewController, animated: animated)
//        }
//
//        func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//            print(self, #function, viewController, animated)
//            // push 或 pop 到 viewController 过程：本方法调用都在 viewController 的 viewDidAppear() 之后
//            assert(interactivePopGestureRecognizer?.delegate === self, "AHKNavigationController won't work correctly if you change interactivePopGestureRecognizer's delegate.")
//            isDuringPushAnimation = false
//            outerDelegate?.navigationController?(navigationController, didShow: viewController, animated: animated)
//        }
//
//        // 手势驱动的返回动画（手势控制动画进度）
//
//        func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//            print(self, #function, animationController)
//            if let rd = outerDelegate {
//                return rd.navigationController?(navigationController, interactionControllerFor: animationController)
//            }
//            // print(navigationController.viewControllers.last!) // 手指驱动返回动画时，顶部的 viewController 已经被pop掉了，所以这儿print的是新的topViewController
//            return percentDrivenTransition
//        }
//
//        func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//            print(self, #function, operation, fromVC, toVC)
//            if let rd = outerDelegate {
//                return  rd.navigationController?(navigationController, animationControllerFor: operation, from: fromVC, to: toVC)
//            }
//
//            switch operation {
//                case .none:
//                    break
//
//                case .pop:
//                    break
//
//                case .push:
//                    break
//            }
//            return nil
//        }
//
//        // 转向问题，不在委托方法中处理
//        //    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {}
//        //    func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {}
//    }
//
//
//    extension BaseNavigationController: UIGestureRecognizerDelegate {
//        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//            if gestureRecognizer == self.interactivePopGestureRecognizer {
//                // Disable pop gesture in two situations:
//                // 1) when the pop animation is in progress
//                // 2) when user swipes quickly a couple of times and animations don't have time to be performed
//                return viewControllers.count > 1 && !isDuringPushAnimation
//            } else {
//                return true // default value
//            }
//        }
//    }
//
//
//
//
//
//    // MARK: - Rotation
//    // TODO: topViewController or visibleViewController ?
//    extension BaseNavigationController {
//        override var shouldAutorotate: Bool {
//            if let rvc = topViewController {
//                return rvc.shouldAutorotate
//            }
//            return false
//        }
//        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//            if let rvc = topViewController {
//                return rvc.supportedInterfaceOrientations
//            }
//            return .portrait
//        }
//        override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//            if let rvc = topViewController {
//                return rvc.preferredInterfaceOrientationForPresentation
//            }
//            return .portrait
//        }
//    }
//
//
//
//    // MARK: - Status Bar
//    extension BaseNavigationController {
//        override var childViewControllerForStatusBarStyle: UIViewController? {
//            return topViewController
//        }
//        override var childViewControllerForStatusBarHidden: UIViewController? {
//            return topViewController
//        }
//        override var prefersStatusBarHidden: Bool {
//            if let vc = topViewController {
//                return vc.prefersStatusBarHidden
//            }
//            return false
//        }
//        override var preferredStatusBarStyle: UIStatusBarStyle {
//            if let vc = topViewController {
//                return vc.preferredStatusBarStyle
//            }
//            return .lightContent
//        }
//        override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
//            if let vc = topViewController {
//                return vc.preferredStatusBarUpdateAnimation
//            }
//            return .fade
//        }
//    }
//
//
//    // MARK: - Navigation
//
//    extension UIViewController {
//        /// 返回按钮不显示任何文字
//        func hideBackBarButtonTitle() {
//            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        }
//
//        func dismissButtonTapped() {
//            dismiss(animated: true, completion: nil)
//        }
//    }
//
//    extension BaseNavigationController {
//
//        override func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
//            print(self, #function, viewControllerToPresent, animated)
//            super.present(viewControllerToPresent, animated: animated, completion: completion)
//        }
//
//        override func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
//            print(self, #function, animated)
//            super.dismiss(animated: animated, completion: completion)
//        }
//
//    }
//}
