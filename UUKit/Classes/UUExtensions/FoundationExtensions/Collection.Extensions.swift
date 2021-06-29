//
//  Collection.Extensions.swift
//  UUKit
//
//  Created by 夏军辉 on 2021/5/18.
//

import Foundation


extension Collection {
    
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    
}


