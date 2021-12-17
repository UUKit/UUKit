//
//  Int.Extensions.swift
//  UUKit
//
//  Created by 夏军辉 on 2021/11/18.
//

import Foundation

extension Int {
    
    //From Decimal
    //10 -> 2
    func decToBinString() -> String {
        let result = createString(radix: 2)
        return result
    }
    
    //10 -> 8
    func decToOctString() -> String {
        //        let result = decToOctStringFormat()
        let result = createString(radix: 8)
        
        return result
    }
    
    //10 -> 16
    func decToHexString() -> String {
        //        let result = decToHexStringFormat()
        let result = createString(radix: 16)
        return result
    }
    
    //10 -> 8
    func decToOctStringFormat(minLength: Int = 0) -> String {
        
        return createString(minLength: minLength, system: "O")
    }
    
    //10 -> 16
    func decToHexStringFormat(minLength: Int = 0) -> String {
        
        return createString(minLength: minLength, system: "X")
    }
    
    fileprivate  func createString(radix: Int) -> String {
        return String(self, radix: radix, uppercase: true)
    }
    
    fileprivate func createString(minLength: Int = 0, system: String) -> String {
        //0 - fill empty space by 0
        //minLength - min count of chars
        //system - system number
        return String(format:"%0\(minLength)\(system)", self)
    }
}
