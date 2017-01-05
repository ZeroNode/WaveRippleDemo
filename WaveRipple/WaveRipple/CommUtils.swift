//
//  CommUtils.swift
//  TeacherAttendance
//
//  Created by mc on 05/01/2017.
//  Copyright © 2017 mc. All rights reserved.
//

import UIKit

class CommUtils:NSObject {
    static let sharedInstance = CommUtils()
    var dateFormatter: NSDateFormatter!
    override init() {
        dateFormatter = NSDateFormatter()
    }
    
    /// 将 时间字符串，转换为指定格式的时间字符串
    func convertDateString(dateStr: String, fromFormat: dateFormat, toFormat: dateFormat) -> String {
        if let date = getDateWithString(dateStr, format: fromFormat){
            let str = getStringWithDate(date, format: toFormat)
            return str
        }else{
            return ""
        }
    }
    /**
     时间转换字符串
     - parameter date:   时间
     - parameter format: 格式
     - returns: 字符串
     */
    func getStringWithDate(date:NSDate , format:dateFormat) -> String {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.stringFromDate(date)
    }
    /**
     字符串转时间
     - parameter str:    字符串
     - parameter format: 格式
     - returns: 时间
     */
    func getDateWithString(str:String , format:dateFormat) -> NSDate? {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.dateFromString(str)
    }
}

/**
 时间格式
 */
enum dateFormat: String {
    // hyphen 连字符
    case yyyyMMddHHmmssSSSWithHyphen    = "yyyy-MM-dd HH:mm:ss.SSS"
    case yyyyMMddHHmmssWithHyphen       = "yyyy-MM-dd HH:mm:ss"
    case yyyyMMddHHmmWithHyphen         = "yyyy-MM-dd HH:mm"
    case yyyyMMddWithHyphen             = "yyyy-MM-dd"
    case yyyyMMWithHyphen               = "yyyy-MM"
    case MMddHHmmWithHyphen             = "MM-dd HH:mm"
    // character 字符
    case MMddWithCharacter              = "MM月dd日"
    case yyyyMMddWithCharacter          = "yyyy年MM月dd日"
    case yyyyMMddHHmmWithCharacter      = "yyyy年MM月dd日 HH:mm"
    
    case yyyyMMddHHmmssSSS              = "yyyyMMddHHmmssSSS"
    
    case HHmm                           = "HH:mm"
    case HHmmss                         = "HH:mm:ss"
    case HHmmNoneHyphen                 = "HHmm"
}
