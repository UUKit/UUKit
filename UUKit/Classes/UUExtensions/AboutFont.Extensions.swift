//
//  AboutFont.Extensions.swift
//  UUKit
//
//  Created by 夏军辉 on 2021/4/20.
//

import UIKit
import Darwin
import Foundation
import CoreGraphics


public protocol UUFontProtocol {
    
    var ultraLight: UIFont { get }
    var thin: UIFont { get }
    var light: UIFont { get }
    var regular: UIFont { get }
    var medium: UIFont { get }
    var semibold: UIFont { get }
    var bold: UIFont { get }
    var heavy: UIFont { get }
    var black: UIFont { get }
    
    var fontSize: CGFloat { get }
}

extension UUFontProtocol {
    
    public var ultraLight: UIFont { return .systemFont(ofSize: abs(self.fontSize), weight: .ultraLight) }
    public var thin: UIFont { return .systemFont(ofSize: abs(self.fontSize), weight: .thin) }
    public var light: UIFont { return .systemFont(ofSize: abs(self.fontSize), weight: .light) }
    public var regular: UIFont { return .systemFont(ofSize: abs(self.fontSize), weight: .regular) }
    public var medium: UIFont { return .systemFont(ofSize: abs(self.fontSize), weight: .medium) }
    public var semibold: UIFont { return .systemFont(ofSize: abs(self.fontSize), weight: .semibold) }
    public var bold: UIFont { return .systemFont(ofSize: abs(self.fontSize), weight: .bold) }
    public var heavy: UIFont { return .systemFont(ofSize: abs(self.fontSize), weight: .heavy) }
    public var black: UIFont { return .systemFont(ofSize: abs(self.fontSize), weight: .black) }
    
}

extension UInt8: UUFontProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension Int8: UUFontProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension UInt16: UUFontProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension Int16: UUFontProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension UInt32: UUFontProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension Int32: UUFontProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension UInt64: UUFontProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension Int64: UUFontProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension UInt: UUFontProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension Int: UUFontProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension Float: UUFontProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}

extension CGFloat: UUFontProtocol {
    public var fontSize: CGFloat { return self }
}

extension NSNumber: UUFontProtocol {
    public var fontSize: CGFloat { return CGFloat(doubleValue) }
}

extension TimeInterval: UUFontProtocol {
    public var fontSize: CGFloat { return CGFloat(self) }
}


