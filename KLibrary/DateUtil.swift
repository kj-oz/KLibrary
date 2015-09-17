//
//  DateUtil.swift
//  KLibrary
//
//  Created by KO on 2015/01/03.
//  Copyright (c) 2015年 KO. All rights reserved.
//

import Foundation

extension NSDate {
  public var components: NSDateComponents {
    let flags = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth |
      NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour |
      NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond
    return NSCalendar.currentCalendar().components(flags, fromDate: self)
  }
  
  public var hour: Int {
    let flags = NSCalendarUnit.CalendarUnitHour
    let comps = NSCalendar.currentCalendar().components(flags, fromDate: self)
    return comps.hour
  }
  
  public var minute: Int {
    let flags = NSCalendarUnit.CalendarUnitMinute
    let comps = NSCalendar.currentCalendar().components(flags, fromDate: self)
    return comps.minute
  }
  
  public var simpleString: String {
    let df = NSDateFormatter()
    df.dateFormat = "yyyy/MM/dd HH:mm:ss"
    return df.stringFromDate(self)
  }
  
  public var dateString: String {
    let df = NSDateFormatter()
    df.dateFormat = "yyyy/MM/dd"
    return df.stringFromDate(self)
  }
  
  public var mdhm: String {
    let df = NSDateFormatter()
    df.dateFormat = "MM/dd HH:mm"
    return df.stringFromDate(self)
  }
  
  public var dateInt: Int {
    let comps = components
    return comps.year * 10000 + comps.month * 100 + comps.day
  }
  
  public static func fromInt(dateInt: Int) -> NSDate? {
    let comps = NSDateComponents()
    comps.year = dateInt / 10000
    let monthday = dateInt % 10000
    comps.month = monthday / 100
    comps.day = monthday % 100
    
    return NSCalendar.currentCalendar().dateFromComponents(comps)
  }
  
  public static func addToDateInt(days: Int, toDate: Int) -> Int {
    var date = NSDate.fromInt(toDate)
    let result = date?.dateByAddingTimeInterval(Double(days) * 60.0 * 60 * 24)
    return result!.dateInt
  }

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
