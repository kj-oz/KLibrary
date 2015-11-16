//
//  DateUtil.swift
//  KLibrary
//
//  Created by KO on 2015/01/03.
//  Copyright (c) 2015年 KO. All rights reserved.
//

import Foundation

/** 
 * NSDateへのユーティリティ関数の追加
 */
extension NSDate {
  /** 年から秒までの全ての要素の値 */
  public var components: NSDateComponents {
    let flags = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth |
      NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour |
      NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond
    return NSCalendar.currentCalendar().components(flags, fromDate: self)
  }
  
  /** 時(整数) */
  public var hour: Int {
    let flags = NSCalendarUnit.CalendarUnitHour
    let comps = NSCalendar.currentCalendar().components(flags, fromDate: self)
    return comps.hour
  }
  
  /** 分(整数) */
  public var minute: Int {
    let flags = NSCalendarUnit.CalendarUnitMinute
    let comps = NSCalendar.currentCalendar().components(flags, fromDate: self)
    return comps.minute
  }
  
  /** yyyy/MM/dd HH:mm:ss 形式の文字列 */
  public var simpleString: String {
    let df = NSDateFormatter()
    df.dateFormat = "yyyy/MM/dd HH:mm:ss"
    return df.stringFromDate(self)
  }
  
  /** yyyy/MM/dd 形式の日付文字列 */
  public var dateString: String {
    let df = NSDateFormatter()
    df.dateFormat = "yyyy/MM/dd"
    return df.stringFromDate(self)
  }
  
  /** MM/dd HH:mm 形式の文字列 */
  public var mdhm: String {
    let df = NSDateFormatter()
    df.dateFormat = "MM/dd HH:mm"
    return df.stringFromDate(self)
  }
  
  /** 年月日の整数(yyyyMMdd) */
  public var dateInt: Int {
    let comps = components
    return comps.year * 10000 + comps.month * 100 + comps.day
  }
  
  /**
   * 年月日整数の表す日付のNSDateオブジェクトを得る
   *
   * :param: dateInt 年月日整数
   * :returns: NSDateオブジェクト
   */
  public static func fromInt(dateInt: Int) -> NSDate? {
    let comps = NSDateComponents()
    comps.year = dateInt / 10000
    let monthday = dateInt % 10000
    comps.month = monthday / 100
    comps.day = monthday % 100
    
    return NSCalendar.currentCalendar().dateFromComponents(comps)
  }
  
  /** 
   * 年月日整数に指定の日数を加えた年月日整数を返す
   *
   * :param: days 加える日数
   * :param: toDate 元の年月日整数
   * :returns: 日数を加えた年月日整数
   */
  public static func addToDateInt(days: Int, toDate: Int) -> Int {
    var date = NSDate.fromInt(toDate)
    let result = date?.dateByAddingTimeInterval(Double(days) * 60.0 * 60 * 24)
    return result!.dateInt
  }
  
  /**
   * 与えられた整数表現の日付の翌日の日付を得る
   *
   * :param: date 日付
   * :returns: 次の日の日付
   */
  public static func tommorow(date: Int) -> Int {
    return NSDate.addToDateInt(1, toDate: date)
  }
  
  /**
   * ２つの年月日整数の差の日数を返す
   *
   * :param: date1 年月日整数1
   * :param: date2 年月日整数2
   * :returns: ２つの年月日整数の差(date1-date2）
   */
  public static func dateIntDiff(date1: Int, _ date2: Int) -> Int {
    let nsdate1 = NSDate.fromInt(date1)
    let nsdate2 = NSDate.fromInt(date2)
    let diff = nsdate1!.timeIntervalSinceDate(nsdate2!)
    return Int(diff) / (60 * 60 * 24)
  }

  /**
   * ちょうど0時0分のNSDateオブジェクトを返す
   *
   * :param: before 現在より前の0時0分かどか
   * :returns: ちょうど0時0分のNSDateオブジェクト
   */
  public func roundToDay(before: Bool = true) -> NSDate {
    let comps = self.components
    if comps.hour == 0 && comps.minute == 0 && comps.second == 0 {
      return self
    }
    comps.hour = 0
    comps.minute = 0
    comps.second = 0
    var roundedDate = NSCalendar.currentCalendar().dateFromComponents(comps)!
    if !before {
      roundedDate = roundedDate.dateByAddingTimeInterval(24 * 60 * 60)
    }
    return roundedDate
  }
  
  /**
   * ちょうど0分のNSDateオブジェクトを返す
   *
   * :param: before 現在より前の0分かどか
   * :returns: ちょうど0分のNSDateオブジェクト
   */
  public func roundToHour(before: Bool = true) -> NSDate {
    let comps = self.components
    if comps.minute == 0 && comps.second == 0 {
      return self
    }
    comps.minute = 0
    comps.second = 0
    var roundedDate = NSCalendar.currentCalendar().dateFromComponents(comps)!
    if !before {
      roundedDate = roundedDate.dateByAddingTimeInterval(60 * 60)
    }
    return roundedDate
  }
}

public class DateUtil {
}
