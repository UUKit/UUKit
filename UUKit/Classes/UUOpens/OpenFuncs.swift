//
//  OpenFuncs.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/8.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import Foundation


/// 创建并设置一个类的属性
/// - Parameter configure: 设置属性的闭包
/// - Returns: 类的实例
public func setup<T: NSObject>(_ configure: ((T) -> Void)? = nil) -> T {
    let t = T.init()
    configure?(t)
    return t
}


/// 设置传入的实例 ( t ) 的属性
/// - Parameters:
///   - t: 传入的实例
///   - configure: 设置属性的闭包
/// - Returns: 实例
public func setup<T: AnyObject>(_ t: T, _ configure: ((T) -> Void)? = nil) -> T {
    configure?(t)
    return t
}

/// 获取类型名 String
/// - e.g. :
/// print(typeName(of: SomeClass()))      // "SomeClass"
/// print(typeName(of: SomeClass.self))  // "SomeClass"
/// print(typeName(of: String()))               // "String"
public func typeName(of some: Any) -> String {
    return (some is Any.Type) ? String(describing: some) : String(describing: type(of: some))
}

/// 获取完整类型名 String
/// - e.g. :
/// print(fullTypeName(of: String()))         // "Swift.String"
public func fullTypeName(of some: Any) -> String {
    return (some is Any.Type) ? String(reflecting: some) : String(reflecting: type(of: some))
}


/// 通过类名获取Swift的类（命名空间）
///
/// - Parameter className: 类名
/// - Returns: 类
public func classFrom(_ className: String, in bundle: Bundle?) -> AnyClass? {
    var _budle: Bundle! = bundle
    if _budle == nil {
        _budle = Bundle.main
    }
    let className = (_budle.name ?? "") + "." + className
    return NSClassFromString(className)
}


/// 获取 App 中所有的类
/// - Returns: App 中所有的类
public func allClasses() -> [AnyClass] {
    let numberOfClasses = Int(objc_getClassList(nil, 0))
    if numberOfClasses > 0 {
        let classesPtr = UnsafeMutablePointer<AnyClass>.allocate(capacity: numberOfClasses)
        defer { classesPtr.deallocate() }
        let autoreleasingClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(classesPtr)
        let count = objc_getClassList(autoreleasingClasses, Int32(numberOfClasses))
        assert(numberOfClasses == count)
        let classes = (0..<numberOfClasses).map { classesPtr[$0] }
        return classes
    }
    return []
}


/// 获取一个类的所有子类的数组
/// - Parameter class: 类型 e.g. UITableViewCell.self
/// - Returns: 返回一个包含所有子类类型和本类型的数组
public func subclasses<T: AnyObject>(of `class`: T.Type) -> [T.Type] {
    return allClasses()
        .filter {
            var someClass: AnyClass? = $0
            while let tmpClass = someClass {
                if ObjectIdentifier(tmpClass) == ObjectIdentifier(`class`) { return true }
                someClass = class_getSuperclass(tmpClass)
            }
            return false
        }
        .compactMap { $0 as? T.Type }
}


/// 获取一个类的所有子类名称的数组
/// - Parameter class: 类型 e.g. UITableViewCell.self
/// - Returns: 返回一个包含所有子类类型和本类型的名称数组
public func subclassesNames<T: AnyObject>(of `class`: T.Type) -> [String] {
    return subclasses(of: `class`).compactMap { String(describing: $0) }
}


/// 获取一个类的所有子类带有命名空间名称的数组
/// - Parameter class: 类型 e.g. UITableViewCell.self
/// - Returns: 返回一个包含所有子类类型和本类型的带有命名空间名称数组
public func subclassesFullNames<T: AnyObject>(of `class`: T.Type) -> [String] {
    return subclasses(of: `class`).compactMap { String(reflecting: $0) }
}
