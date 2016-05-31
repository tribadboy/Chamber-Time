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
        
        let taskDate = UILabel()
        self.taskDate = taskDate
        self.addSubview(taskDate)
        
        let taskListView = UITextView()
        taskListView.editable = false
        taskListView.backgroundColor = UIColor(red: 215/255.0, green: 235/255.0, blue: 230/255.0, alpha: 0.9)
        self.taskListView = taskListView
        
        let today: NSDate = NSDate()
        setTextView(today.getYear(), month: today.getMonth(), day: today.getDay())
        taskListView.font = taskListView.font?.fontWithSize(16)
        self.addSubview(taskListView)
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
        self.contentView.frame.size.height = 200
        
        self.taskDate.frame.origin.y = 270
        self.taskDate.frame.size.width = self.frame.size.width
        self.taskDate.frame.size.height = 30
        self.taskDate.textAlignment = NSTextAlignment.Center
        self.taskListView.frame.origin.y = 300
        self.taskListView.frame.size.width = self.frame.size.width
        self.taskListView.frame.size.height = 200
        
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
    
    var taskDate: UILabel!
    var taskListView : UITextView!
    
    func setTextView(year: Int, month: Int,day: Int) {
        taskDate.text = "" +  String(month) + "月" +  String(day) + "日"
        var text: String = ""
        if tasks?.count > 0 {
            for index in 0...((tasks?.count)!-1) {
                let task: ToDoTask = (tasks?.objectAtIndex(index))! as! ToDoTask
                let taskDate = task.date
                if year == taskDate?.getYear() && month == taskDate?.getMonth()
                    && day == taskDate?.getDay() {
                    text += NSDate.getFormatDateString_HHmm(taskDate!) + "  " + ((task.title)! as String) + "\n\t" + (task.desc as String)  + "\n\n"
                
                }
                
            }
        }
        if(text == "") {
            let today: NSDate = NSDate()
            if(year == today.getYear() && month == today.getMonth() && day == today.getDay()) {
                text = "今日没有任务安排，尽情享受闲暇的时光吧！"
            } else {
                text = "该日期暂未安排任何任务!"
            }
            
        }
        taskListView.text = text
    }
    
    func clearTextView() {
        taskDate.text = nil
        taskListView = nil
    }
    
    
}
