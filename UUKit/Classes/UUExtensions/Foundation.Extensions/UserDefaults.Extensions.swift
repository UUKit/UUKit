//
//  UserDefaults.Extensions.swift
//  UUKit
//
//  Created by 夏军辉 on 2021/11/3.
//

import Foundation

extension UserDefaults {
    
    /*
     // 程序启动
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
         // 判断当前版本是否第一次启动
         if UserDefaults.isFirstLaunchOfCurrentVersion() {
             //显示新功能介绍页
             print("当前版本第一次启动")
             let introductionViewController = IntroductionViewController()
             self.window!.rootViewController = introductionViewController
         }
     
         // 判断是否第一次启动（两个都是第一次则以这个为准）
         if UserDefaults.isFirstLaunch() {
             //显示新手指导页
             print("应用第一次启动")
             let guideViewController = GuideViewController()
             self.window!.rootViewController = guideViewController
         }
         
         return true
     }
     */
    
    /// 应用第一次启动
    public static func isFirstLaunch() -> Bool {
        let hasBeenLaunched = "hasBeenLaunched"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunched)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: hasBeenLaunched)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
    
    //当前版本第一次启动
    public static func isFirstLaunchOfCurrentVersion() -> Bool {
        //主程序版本号
        let infoDictionary = Bundle.main.infoDictionary!
        let majorVersion = infoDictionary["CFBundleShortVersionString"] as! String
        
        //上次启动的版本号
        let hasBeenLaunchedOfNewVersion = "hasBeenLaunchedOfNewVersion"
        let lastLaunchVersion = UserDefaults.standard.string(forKey: hasBeenLaunchedOfNewVersion)
        
        //版本号比较
        let isFirstLaunchOfNewVersion = majorVersion != lastLaunchVersion
        if isFirstLaunchOfNewVersion {
            UserDefaults.standard.set(majorVersion, forKey: hasBeenLaunchedOfNewVersion)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunchOfNewVersion
    }
}
