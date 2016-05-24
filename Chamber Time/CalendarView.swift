//
//  CalendarView.swift
//  Chamber Time
//
//  Created by YangYueyang on 16/5/23.
//  Copyright © 2016年 NJU. All rights reserved.
//

import UIKit
@objc protocol CalendarViewDelegate {
    /**
     点击选择的日期 可选的
     */
    optional func CalendarViewSelectDate(year:Int,month:Int,day:Int)
}
typealias selectClosure = (year:Int,month:Int,day:Int) -> Void

class CalendarView: UIView ,CalendarContentViewDelegate{
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: selectDate)
        let topView = CalendarHeadView()
        self.topView = topView
        self.addSubview(topView)
        
        let contentView = CalendarContentView()
        self.contentView = contentView
        self.contentView.delegate = self
        self.addSubview(contentView)
    }
    class func show(view : UIView , frame : CGRect,selectDate : selectClosure)->CalendarView{
        let calendarView = CalendarView(frame: frame)
        calendarView.tempclosure = selectDate
        view.addSubview(calendarView)
        return calendarView
    }
    /*
     var titleColor : UIColor?{
     didSet {
     topView.titleLabel.textColor = titleColor
     }
     }
     var topColor : UIColor?{
     didSet {
     topView.backgroundColor = topColor
     }
     }
     */
    //MARK:布局
    override func layoutSubviews() {
        self.topView.frame.size.width = self.frame.size.width
        self.topView.frame.size.height = 50
        
        self.contentView.frame.origin.y = 50
        self.contentView.frame.size.width = self.frame.size.width
        self.contentView.frame.size.height = self.frame.size.height - 50
    }
    //MARK:     CalendarContentViewDelegate
    func calendarContentViewCurrentDate(date: NSDate) {
        self.topView.titleLabel.text = date.getFormatDate()
    }
    func calendarContemViewSelectDate(year: Int, month: Int, day: Int) {
        self.delegate?.CalendarViewSelectDate?(year, month: month, day: day)
        self.tempclosure?(year: year, month: month, day: day)
    }
    //MARK:属性
    var topView     : CalendarHeadView!
    var contentView : CalendarContentView!
    var delegate    : CalendarViewDelegate?
    var tempclosure : selectClosure?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
