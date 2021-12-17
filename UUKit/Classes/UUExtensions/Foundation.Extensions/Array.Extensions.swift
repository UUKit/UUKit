//
//  ArrayExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/7/30.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import Foundation

extension Array {
    
    /// 格式化成 JSON 数据
    public var toJSON: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else { return nil }
        guard let JSON = String(data: data, encoding: .utf8) else { return nil }
        return JSON
    }
    
    /// 式化成 JSON 数据，根据传入的 options 格式成打印的样式，或其他格式
    public func toJSON(withWritingOptions options: JSONSerialization.WritingOptions = [.prettyPrinted]) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        guard let JSON = String(data: data, encoding: .utf8) else { return nil }
        return JSON
    }
    
}

extension Array {
    
    @discardableResult
    public mutating func safeRemove(at index: Index) -> Bool {
        guard indices.contains(index) else { return false }
        remove(at: index)
        return true
    }
    
    
}


public extension Array where Element: Equatable {
    /// SwifterSwift: Remove all instances of an item from array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeAll(2) -> [1, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"].removeAll("l") -> ["h", "e", "o"]
    ///
    /// - Parameter item: item to remove.
    /// - Returns: self after removing all instances of item.
    @discardableResult
    mutating func removeAll(_ item: Element) -> [Element] {
        removeAll(where: { $0 == item })
        return self
    }

    /// SwifterSwift: Remove all instances contained in items parameter from array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeAll([2,5]) -> [1, 3, 4]
    ///        ["h", "e", "l", "l", "o"].removeAll(["l", "h"]) -> ["e", "o"]
    ///
    /// - Parameter items: items to remove.
    /// - Returns: self after removing all instances of all items in given array.
    @discardableResult
    mutating func removeAll(_ items: [Element]) -> [Element] {
        guard !items.isEmpty else { return self }
        removeAll(where: { items.contains($0) })
        return self
    }

    /// SwifterSwift: Remove all duplicate elements from Array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeDuplicates() -> [1, 2, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"]. removeDuplicates() -> ["h", "e", "l", "o"]
    ///
    /// - Returns: Return array with all duplicate elements removed.
    @discardableResult
    mutating func removeDuplicates() -> [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
        return self
    }

    /// SwifterSwift: Return array with all duplicate elements removed.
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].withoutDuplicates() -> [1, 2, 3, 4, 5])
    ///     ["h", "e", "l", "l", "o"].withoutDuplicates() -> ["h", "e", "l", "o"])
    ///
    /// - Returns: an array of unique elements.
    ///
    func withoutDuplicates() -> [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
        return reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }

    /// SwifterSwift: Returns an array with all duplicate elements removed using KeyPath to compare.
    ///
    /// - Parameter path: Key path to compare, the value must be Equatable.
    /// - Returns: an array of unique elements.
    func withoutDuplicates<E: Equatable>(keyPath path: KeyPath<Element, E>) -> [Element] {
        return reduce(into: [Element]()) { result, element in
            if !result.contains(where: { $0[keyPath: path] == element[keyPath: path] }) {
                result.append(element)
            }
        }
    }

    /// SwifterSwift: Returns an array with all duplicate elements removed using KeyPath to compare.
    ///
    /// - Parameter path: Key path to compare, the value must be Hashable.
    /// - Returns: an array of unique elements.
    func withoutDuplicates<E: Hashable>(keyPath path: KeyPath<Element, E>) -> [Element] {
        var set = Set<E>()
        return filter { set.insert($0[keyPath: path]).inserted }
    }
    
}


extension Array {
    
    /// 从数组中返回一个随机元素
    public var sample: Element? {
        //如果数组为空，则返回nil
        guard count > 0 else { return nil }
        let randomIndex = Int(arc4random_uniform(UInt32(count)))
        return self[randomIndex]
    }
    
    /// 从数组中从返回指定个数的元素
    ///
    /// - Parameters:
    ///   - size: 希望返回的元素个数
    ///   - noRepeat: 返回的元素是否不可以重复（默认为false，可以重复）
    public func sample(size: Int, noRepeat: Bool = false) -> [Element]? {
        //如果数组为空，则返回nil
        guard !isEmpty else { return nil }
        
        var sampleElements: [Element] = []
        
        //返回的元素可以重复的情况
        if !noRepeat {
            for _ in 0..<size {
                sampleElements.append(sample!)
            }
        }
        //返回的元素不可以重复的情况
        else {
            //先复制一个新数组
            var copy = self.map { $0 }
            for _ in 0..<size {
                //当元素不能重复时，最多只能返回原数组个数的元素
                if copy.isEmpty { break }
                let randomIndex = Int(arc4random_uniform(UInt32(copy.count)))
                let element = copy[randomIndex]
                sampleElements.append(element)
                //每取出一个元素则将其从复制出来的新数组中移除
                copy.remove(at: randomIndex)
            }
        }
        return sampleElements
    }
    
    
}
