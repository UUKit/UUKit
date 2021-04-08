//
//  OpenUserDefaultsKeys.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/17.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    public struct AppStart: UserDefaultsProtocol {
        public enum EnumKeys: String {
            case isRelaunch
            case isLoggedIn
        }
    }
    
}
