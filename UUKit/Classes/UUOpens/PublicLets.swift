//
//  OpenVars.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/8.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit

public let SCREEN_BOUNDS     = UIScreen.main.bounds
public let SCREEN_WIDTH      = UIScreen.main.bounds.width
public let SCREEN_HEIGHT     = UIScreen.main.bounds.height
//public let STATUS_BAR_HEIGHT = UIApplication.shared.statusBarFrame.height
//public let TOP_HEIGHT        = UIApplication.shared.statusBarFrame.height + 44.0
//public let HOME_BAR_HEIGHT   = UIApplication.shared.statusBarFrame.height > 20.0 ? 34.0 as CGFloat : 0.0  as CGFloat
//public let TAB_BAR_HEIGHT    = UIApplication.shared.statusBarFrame.height > 20.0 ? 83.0 as CGFloat : 49.0 as CGFloat
public let AppVersion        = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""


public var STATUS_BAR_HEIGHT: CGFloat {
    if #available(iOS 13.0, *) {
        let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
        return statusBarManager?.statusBarFrame.height ?? 0
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
}
