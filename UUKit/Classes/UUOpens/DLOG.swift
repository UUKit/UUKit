//
//  DLOG.swift
//  UUKit
//
//  Created by uxiu.me on 2018/4/18.
//  Copyright © 2018年 uxiu.me All rights reserved.
//

import Foundation

#if DEBUG

//MARK:- 自定义打印日志
public func DLog<T>(_ message: T, filePath: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    //文件名、方法、行号、打印信息
    print("\n\n"+"▩◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▣◈▩")
    let file: NSString = filePath as NSString
    let formator = DateFormatter()
    formator.dateFormat = "yyyy-MM-DD EEEE HH:mm:ss"
    let str = formator.string(from: Date())
    print("😸【类名】 :\(file.lastPathComponent.utf8)    😸【方法】 :\(methodName)\n😸【行号】 :\(lineNumber)\n😸【内容】 :输出 \(str)\n\(message)\n\n")
}

/// 定义方法打印对象内存地址
func DLogAddress(values:AnyObject...) {
    for value in values {
        DLog(Unmanaged.passUnretained(value).toOpaque())
    }
}


#else

public func DLog<T>(_ message: T, filePath: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    
}

func DLogAddress(values:AnyObject...) {
    
}

#endif
