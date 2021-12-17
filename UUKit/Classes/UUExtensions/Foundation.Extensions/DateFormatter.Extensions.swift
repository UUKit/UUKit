//
//  DateFormatter.Extensions.swift
//  UUKit
//
//  Created by mac on 2020/12/22.
//

import Foundation

/*
 dash      横线、横杠    (-)
 slash     斜线、斜杠    (/)
 backslash 反斜线、反斜杠 (\)
 */


public enum DateFormat: String, CaseIterable {
    
    case utc = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // 世界统一时间'UTC'  "2020-07-20T13:45:33.873+0000"
    
    case yyyyMMdd = "yyyyMMdd" // "20200720"
    case yyyyMMdd_Dash = "yyyy-MM-dd" // "2020-07-20"
    case yyyyMMdd_Slash = "yyyy/MM/dd" // "2020/07/20"
    case yyyyMMdd_Space = "yyyy MM dd" // "2020 07 20"
    case yyyyMMdd_Chinese = "yyyy年MM月dd日" // "2020年07月20日"
    
    case yyyyMM = "yyyyMM" // "202007"
    case yyyyMM_Dash = "yyyy-MM" // "2020-07"
    case yyyyMM_Slash = "yyyy/MM" // "2020/07"
    case yyyyMM_Space = "yyyy MM" // "2020 07"
    case yyyyMM_Chinese = "yyyy年MM月" // "2020年07月"
    
    case MMdd = "MMdd" // "0720"
    case MMdd_Dash = "MM-dd" // "07-20"
    case MMdd_Slash = "MM/dd" // "07/20"
    case MMdd_Space = "MM dd" // "07 20"
    case MMdd_Chinese = "MM月dd日" // "07月20日"
    
    case yyMMdd = "yyMMdd" // "200720"
    case yyMMdd_Dash = "yy-MM-dd" // "20-07-20"
    case yyMMdd_Slash = "yy/MM/dd" // "20/07/20"
    case yyMMdd_Space = "yy MM dd" // "20 07 20"
    case yyMMdd_Chinese = "yy年MM月dd日" // "20年07月20日"
    
    case yyMM = "yyMM" // "2007"
    case yyMM_Dash = "yy-MM" // "20-07"
    case yyMM_Slash = "yy/MM" // "20/07"
    case yyMM_Space = "yy MM" // "20 07"
    case yyMM_Chinese = "yy年MM月" // "20年07月"
    
    case yyyyMMddHHmm = "yyyyMMddHHmm" // "202007201345"
    case yyyyMMddHHmm_Dash = "yyyy-MM-dd HH:mm" // "2020-07-20 13:45"
    case yyyyMMddHHmm_Slash = "yyyy/MM/dd HH:mm" // "2020/07/20 13:45"
    case yyyyMMddHHmm_Space = "yyyy MM dd HH:mm" // "2020 07 20 13:45"
    case yyyyMMddHHmm_Chinese = "yyyy年MM月dd日 HH时mm分" // "2020年07月20日 13时45分"
    
    case yyyyMMddHHmmss = "yyyyMMddHHmmss" // "20200720134533"
    case yyyyMMddHHmmss_Dash = "yyyy-MM-dd HH:mm:ss" // "2020-07-20 13:45:33"
    case yyyyMMddHHmmss_Slash = "yyyy/MM/dd HH:mm:ss" // "2020/07/20 13:45:33"
    case yyyyMMddHHmmss_Space = "yyyy MM dd HH:mm:ss" // "2020 07 20 13:45:33"
    case yyyyMMddHHmmss_Chinese = "yyyy年MM月dd日 HH时mm分ss秒" // "2020年07月20日 13时45分33秒"
    
    case HHmmss = "HH:mm:ss"
    case HHmmss_Chinese = "HH时mm分ss秒"
    case HHmm = "HH:mm"
    case HHmm_Chinese = "HH时mm分"
    
    case year = "yyyy"
    case month = "MM"
    case day = "dd"
    case hour = "HH"
    case minutes = "mm"
    case seconds = "ss"
    
    case year_Chinese = "yyyy年"
    case month_Chinese = "MM月"
    case day_Chinese = "dd日"
    case hour_Chinese = "HH时"
    case minutes_Chinese = "mm分"
    case seconds_Chinese = "ss秒"
    
    //startOfDay,// yyyy-MM-dd HH:mm:ss @"2020-07-20 00:00:00"
    //endOfDay,// yyyy-MM-dd HH:mm:ss @"2020-07-20 23:59:59"
    
    
}











