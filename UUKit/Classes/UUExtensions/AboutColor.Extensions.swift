//
//  AboutColor.Extensions.swift
//  UUKit
//
//  Created by 夏军辉 on 2021/4/26.
//

import Foundation

public protocol UUColorProtocol {
    var color: UIColor { get }
}

extension String: UUColorProtocol {
    
    public var color: UIColor {
        let formattedHEX = self
            .replacingOccurrences(of: "0x", with: "")
            .replacingOccurrences(of: "0X", with: "")
            .replacingOccurrences(of: "#" , with: "")
        let scanner = Scanner(string: "0x\(formattedHEX)")
        scanner.scanLocation = 0
        var hexInt: UInt64 = 0
        scanner.scanHexInt64(&hexInt)
        return UIColor(hex: hexInt)
    }
    
    
}


extension Int: UUColorProtocol {
    
    public var color: UIColor {
        let r = CGFloat((self & 0xff0000) >> 16)
        let g = CGFloat((self & 0x00ff00) >> 8)
        let b = CGFloat( self & 0x0000ff)
        return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    
}



