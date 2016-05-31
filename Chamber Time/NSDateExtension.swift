//
//  NSDateExtension.swift
//  Chamber Time
//
//  Created by YangYueyang on 16/5/23.
//  Copyright © 2016年 NJU. All rights reserved.
//

import Foundation
import UIKit

extension NSDate {
    /**
     获取这个月有多少天
     */
    func getMonthHowManyDay() -> Int {
        //我们大致可以理解为：某个时间点所在的“小单元”，在“大单元”中的数量
        return NSCalendar.currentCalendar().rangeOfUnit(.Day, inUnit:.Month, forDate: self).length
    }
    /**
     *  获取这个月第一天是星期几
     */
    func getMontFirstWeekDay() -> Int {
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let calendar = NSCalendar.currentCalendar()
        //这里注意 swift要用[,]这样方式写
        let com = calendar.components([.Year,.Month,.Day], fromDate: self)
        //设置成第一天
        com.day = 1
        let date = calendar.dateFromComponents(com)
        //我们大致可以理解为：某个时间点所在的“小单元”，在“大单元”中的位置  ordinalityOfUnit
        let firstWeekDay = calendar.ordinalityOfUnit(.Weekday, inUnit: .WeekOfMonth, forDate: date!)
        return firstWeekDay - 1
    }
    /**
     *  获取当前Day
     */
    func getDay() -> Int {
        let calendar = NSCalendar.currentCalendar()
        //这里注意 swift要用[,]这样方式写
        let com = calendar.components([.Year,.Month,.Day], fromDate: self)
        return com.day
    }
    /**
     *  获取当前Month
     */
    
    func getMonth() -> Int {
        let calendar = NSCalendar.currentCalendar()
        //这里注意 swift要用[,]这样方式写
        let com = calendar.components([.Year,.Month,.Day], fromDate: self)
        return com.month
    }
 
    /**
     *  获取当前Year
     */
    func getYear() -> Int {
        let calendar = NSCalendar.currentCalendar()
        //这里注意 swift要用[,]这样方式写
        let com = calendar.components([.Year,.Month,.Day], fromDate: self)
        return com.year
    }
    
    /**
     获取指定时间下一个月的时间
     */
    func getNextDate() ->NSDate {
        let calendar = NSCalendar.currentCalendar()
        let com = calendar.components([.Year,.Month,.Day], fromDate: self)
        com.month += 1
        return calendar.dateFromComponents(com)!
    }
    /**
     获取指定时间上一个月的时间
     */
    func getLastDate() ->NSDate {
        let calendar = NSCalendar.currentCalendar()
        let com = calendar.components([.Year,.Month,.Day], fromDate: self)
        com.month -= 1
        return calendar.dateFromComponents(com)!
    }
    /**
     获取指定时间下一个月的长度
     */
    func getNextDateLenght() ->Int {
        let date = self.getNextDate()
        return date.getMonthHowManyDay()
    }
    /**
     获取指定时间上一个月的长度
     */
    func getLastDateLenght() ->Int {
        let date = self.getLastDate()
        return date.getMonthHowManyDay()
    }
    
    func getFormatDate() ->String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy.MM"
        return  dateFormatter.stringFromDate(self)
    }
    /**
     是否是今天
     */
    func isToday()->Bool {
        let calendar = NSCalendar.currentCalendar()
        /// 获取self的时间
        let comSelf = calendar.components([.Year,.Month,.Day], fromDate: self)
        /// 获取当前的时间
        let comNow = calendar.components([.Year,.Month,.Day], fromDate: NSDate())
        return comSelf.year==comNow.year && comSelf.month==comNow.month && comSelf.day==comNow.day
    }
    /**
     是否是这个月
     */
    func isEqualMonth(date : NSDate)->Bool {
        let calendar = NSCalendar.currentCalendar()
        /// 获取self的时间
        let comSelf = calendar.components([.Year,.Month,.Day], fromDate: self)
        /// 获取当前的时间
        let comNow = calendar.components([.Year,.Month,.Day], fromDate: date)
        return comSelf.year==comNow.year && comSelf.month==comNow.month
    }
    /**
     是否是这个月
     */
    func isThisMonth()->Bool {
        let calendar = NSCalendar.currentCalendar()
        /// 获取self的时间
        let comSelf = calendar.components([.Year,.Month,.Day], fromDate: self)
        /// 获取当前的时间
        let comNow = calendar.components([.Year,.Month,.Day], fromDate: NSDate())
        return comSelf.year==comNow.year && comSelf.month==comNow.month
    }
    /**
     分别获取准确的年月日
     */
    func getDateY_M_D(day : Int)->(year:Int,month:Int,day:Int) {
        let calendar = NSCalendar.currentCalendar()
        let comSelf = calendar.components([.Year,.Month,.Day], fromDate: self)
        comSelf.day = day
        return (comSelf.year,comSelf.month,comSelf.day)
        
    }
    /**
     获取指定date
     */
    func getDate(day : Int)-> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let comSelf = calendar.components([.Year,.Month,.Day], fromDate: self)
        comSelf.day = day
        return calendar.dateFromComponents(comSelf)!
        
    }
    
    class func stringToDate(dateString : String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString(dateString)
        return date
    }
    
    
    
    class func getRecentDate(date : NSDate) ->NSArray {
        
        return [date.getLastDate().getLastDate(),date.getLastDate(),date,date.getNextDate(),date.getNextDate().getNextDate()]
    }
    
    class func isEqualDateyyyyMMdd(date1: NSDate, date2: NSDate) -> Int {
        print(date1.getDay())
        print(date2.getDay())
        if(date1.getYear() == date2.getYear() &&
            date1.getMonth() == date2.getMonth() &&
            date1.getDay() == date2.getDay()) {
            return 1
        }
        return 0
    }
    
    class func getFormatDateString_HHmm(date: NSDate) ->String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return  dateFormatter.stringFromDate(date)
    }
}

