//
//  UserDefaultsExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/17.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import Foundation

public protocol UserDefaultsProtocol {
    associatedtype EnumKeys: RawRepresentable
}

extension UserDefaultsProtocol where EnumKeys.RawValue == String {
    
    
    //MARK: - object
    public static func set(_ value: Any?, forKey akey: EnumKeys) {
        UserDefaults.standard.set(value, forKey: akey.rawValue)
    }
    
    
    public static func removeObject(forKey akey: EnumKeys) {
        UserDefaults.standard.removeObject(forKey: akey.rawValue)
    }
    
    
    public static func object(forKey akey: EnumKeys) -> Any? {
        return UserDefaults.standard.object(forKey: akey.rawValue)
    }
    
    
    public static func string(forKey akey: EnumKeys) -> String? {
        return UserDefaults.standard.string(forKey: akey.rawValue)
    }
    
    
    public static func array(forKey akey: EnumKeys) -> [Any]? {
        return UserDefaults.standard.array(forKey: akey.rawValue)
    }
    
    
    public static func dictionary(forKey akey: EnumKeys) -> [String : Any]? {
        return UserDefaults.standard.dictionary(forKey: akey.rawValue)
    }
    
    
    public static func data(forKey akey: EnumKeys) -> Data? {
        return UserDefaults.standard.data(forKey: akey.rawValue)
    }
    
    
    public static func stringArray(forKey akey: EnumKeys) -> [String]? {
        return UserDefaults.standard.stringArray(forKey: akey.rawValue)
    }
    
    
    //MARK: - bool
    /// -setBool:forKey: is equivalent to -setObject:forKey: except that the value is converted from a BOOL to an NSNumber.
    public static func set(_ value: Bool, forKey akey: EnumKeys) {
        UserDefaults.standard.set(value, forKey: akey.rawValue)
    }
    
    
    /*!
     -boolForKey: is equivalent to -objectForKey:, except that it converts the returned value to a BOOL. If the value is an NSNumber, NO will be returned if the value is 0, YES otherwise. If the value is an NSString, values of "YES" or "1" will return YES, and values of "NO", "0", or any other string will return NO. If the value is absent or can't be converted to a BOOL, NO will be returned.
     
     */
    public static func bool(forKey akey: EnumKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: akey.rawValue)
    }
    
    //MARK: - String
    
    
    //MARK: - Int
    /// -setInteger:forKey: is equivalent to -setObject:forKey: except that the value is converted from an NSInteger to an NSNumber.
    public static func set(_ value: Int, forKey akey: EnumKeys) {
        UserDefaults.standard.set(value, forKey: akey.rawValue)
    }
    
    
    /*!
     -integerForKey: is equivalent to -objectForKey:, except that it converts the returned value to an NSInteger. If the value is an NSNumber, the result of -integerValue will be returned. If the value is an NSString, it will be converted to NSInteger if possible. If the value is a boolean, it will be converted to either 1 for YES or 0 for NO. If the value is absent or can't be converted to an integer, 0 will be returned.
     */
    public static func integer(forKey akey: EnumKeys) -> Int {
        return UserDefaults.standard.integer(forKey: akey.rawValue)
    }
    
    
    //MARK: - Float
    /// -setFloat:forKey: is equivalent to -setObject:forKey: except that the value is converted from a float to an NSNumber.
    public static func set(_ value: Float, forKey akey: EnumKeys) {
        UserDefaults.standard.set(value, forKey: akey.rawValue)
    }
    
    
    public static func float(forKey akey: EnumKeys) -> Float {
        return UserDefaults.standard.float(forKey: akey.rawValue)
    }
    
    
    //MARK: - Double
    /// -setDouble:forKey: is equivalent to -setObject:forKey: except that the value is converted from a double to an NSNumber.
    public static func set(_ value: Double, forKey akey: EnumKeys) {
        UserDefaults.standard.set(value, forKey: akey.rawValue)
    }
    
    
    public static func double(forKey akey: EnumKeys) -> Double {
        return UserDefaults.standard.double(forKey: akey.rawValue)
    }
    
    
    //MARK: - URL
    /// -setURL:forKey is equivalent to -setObject:forKey: except that the value is archived to an NSData. Use -URLForKey: to retrieve values set this way.
    @available(iOS 4.0, *)
    public static func set(_ url: URL?, forKey akey: EnumKeys) {
        UserDefaults.standard.set(url, forKey: akey.rawValue)
    }
    
    
    /*!
     -URLForKey: is equivalent to -objectForKey: except that it converts the returned value to an NSURL. If the value is an NSString path, then it will construct a file URL to that path. If the value is an archived URL from -setURL:forKey: it will be unarchived. If the value is absent or can't be converted to an NSURL, nil will be returned.
     */
    @available(iOS 4.0, *)
    public static func url(forKey akey: EnumKeys) -> URL? {
        return UserDefaults.standard.url(forKey: akey.rawValue)
    }
}
