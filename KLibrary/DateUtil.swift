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
