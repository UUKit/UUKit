//
//  AboutDate.Extensions.swift
//  AAChartKit
//
//  Created by mac on 2020/12/23.
//

import Foundation
import CoreGraphics

public protocol UUTimeIntervalProtocol {
    var timeInterval: TimeInterval { get }
}

enum UUTimeUnit {
    case seconds
    case minutes
    
//    func ago() -> Date {
//        <#function body#>
//    }
    
//    - (BOOL)isLeapYear {
//        NSUInteger year = self.year;
//        return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
//    }
//
//    - (BOOL)isToday {
//        if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
//        return [NSDate new].day == self.day;
//    }
//
//    - (BOOL)isYesterday {
//        NSDate *added = [self dateByAddingDays:1];
//        return [added isToday];
//    }
//
//    - (NSDate *)dateByAddingYears:(NSInteger)years {
//        NSCalendar *calendar =  [NSCalendar currentCalendar];
//        NSDateComponents *components = [[NSDateComponents alloc] init];
//        [components setYear:years];
//        return [calendar dateByAddingComponents:components toDate:self options:0];
//    }
//
//    - (NSDate *)dateByAddingMonths:(NSInteger)months {
//        NSCalendar *calendar = [NSCalendar currentCalendar];
//        NSDateComponents *components = [[NSDateComponents alloc] init];
//        [components setMonth:months];
//        return [calendar dateByAddingComponents:components toDate:self options:0];
//    }
//

}

extension UUTimeIntervalProtocol {
    public var seconds: TimeInterval { return timeInterval * 1 }
    public var minutes: TimeInterval { return timeInterval * 60 /* 一分钟秒数 */ }
    public var hours: TimeInterval { return timeInterval * (60 * 60) /* 一小时秒数 */ }
    public var days: TimeInterval { return timeInterval * (24 * 60 * 60) /* 一天的秒数 */ }
    public var weeks: TimeInterval { return timeInterval * (7 * 24 * 60 * 60) /* 一星期秒数 */ }
    
    var months: TimeInterval {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = Int(timeInterval)
        let date = calendar.date(byAdding: components, to: Date())
        return date?.timeIntervalSinceNow ?? 0
    }
    
    var years: TimeInterval {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = Int(timeInterval)
        let date = calendar.date(byAdding: components, to: Date())
        return date?.timeIntervalSinceNow ?? 0
    }
}

extension TimeInterval {
    
    public func fromNow() -> Date {
        return Date(timeIntervalSinceNow: self)
    }
    
    public func ago() -> Date {
        return before(Date())
    }
    
    public func later() -> Date {
        return after(Date())
    }
    
    public func after(_ date: Date = Date()) -> Date {
        return Date(timeInterval: self, since: date)
    }
    
    public func before(_ date: Date = Date()) -> Date {
        return Date(timeInterval: -self, since: date)
    }
    
}

extension UInt8: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return TimeInterval(self) }
}

extension Int8: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return TimeInterval(self) }
}

extension UInt16: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return TimeInterval(self) }
}

extension Int16: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return TimeInterval(self) }
}

extension UInt32: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return TimeInterval(self) }
}

extension Int32: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return TimeInterval(self) }
}

extension UInt64: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return TimeInterval(self) }
}

extension Int64: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return TimeInterval(self) }
}

extension UInt: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return TimeInterval(self) }
}

extension Int: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return TimeInterval(self) }
}

extension Float: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return TimeInterval(self) }
}

extension CGFloat: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return TimeInterval(self) }
}

extension NSNumber: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return doubleValue }
}

extension TimeInterval: UUTimeIntervalProtocol {
    public var timeInterval: TimeInterval { return self }
}


