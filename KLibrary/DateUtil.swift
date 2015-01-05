//
//  DateUtil.swift
//  KLibrary
//
//  Created by KO on 2015/01/03.
//  Copyright (c) 2015年 KO. All rights reserved.
//

import Foundation

public class DateUtil {
    var calendar = NSCalendar.currentCalendar()
    
    public init() {
    }
    
    public func truncateToDay(date: NSDate) -> NSDate? {
        var flags = NSCalendarUnit.YearCalendarUnit |
            NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.DayCalendarUnit
        var comps = calendar.components(flags, fromDate: date)
        return calendar.dateFromComponents(comps)
    }
    
    public func getMinute(date:NSDate) -> Int {
        var flags = NSCalendarUnit.MinuteCalendarUnit
        var comps = calendar.components(flags, fromDate: date)
        return comps.minute
    }
    
    public func getHour(date:NSDate) -> Int {
        var flags = NSCalendarUnit.HourCalendarUnit
        var comps = calendar.components(flags, fromDate: date)
        return comps.hour
    }
    
    public func getTime(date:NSDate) -> NSDateComponents {
        var flags = NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit |
            NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.HourCalendarUnit |
            NSCalendarUnit.MinuteCalendarUnit | NSCalendarUnit.SecondCalendarUnit
        return calendar.components(flags, fromDate: date)
    }
    
}
