//
//  ToDoTask.swift
//  Chamber Time
//
//  Created by YangYueyang on 16/5/24.
//  Copyright © 2016年 NJU. All rights reserved.
//

import UIKit

var tasks : [ToDoTask] = [ToDoTask(id: "1", imageId: "学习", title: "完成软件工程课程作业",date: NSDate.stringToDate("2016-11-2")!),
                          ToDoTask(id: "2", imageId: "娱乐", title: "看电影《美国队长3》",date: NSDate.stringToDate("2016-11-23")!),
                          ToDoTask(id: "3", imageId: "电话", title: "实习电话面试",date: NSDate.stringToDate("2016-8-27")!),
                          ToDoTask(id: "4", imageId: "旅行", title: "去上海旅行",date: NSDate.stringToDate("2016-9-25")!),
                          ToDoTask(id: "5", imageId: "约会", title: "约会",date: NSDate.stringToDate("2016-10-24")!),
]

class ToDoTask: NSObject {
    var id: String
    var imageId: String
    var title: String
    var date: NSDate
    var desc: String
    
    init (id:String, imageId: String, title: String , date: NSDate, desc: String) {
        self.id = id
        self.imageId = imageId
        self.title = title
        self.date = date
        self.desc = desc
    }
    
    init (id:String, imageId: String, title: String , date: NSDate) {
        self.id = id
        self.imageId = imageId
        self.title = title
        self.date = date
        self.desc = ""
    }
}
