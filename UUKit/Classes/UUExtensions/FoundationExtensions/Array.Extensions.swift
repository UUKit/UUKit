//
//  ArrayExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/7/30.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import Foundation

extension Array {
    
    public mutating func append(from arr: Array<Element>) -> Array {
        for item  in arr {
            self.append(item)
        }
        return self
    }
    
//    mutating func remove<T>(_ anElement: T) -> Array {
//        for (index,element) in self.enumerated() {
//            if anElement == element {
//                self.remove(at: index)
//            }
//        }
//        return self
//    }
}
