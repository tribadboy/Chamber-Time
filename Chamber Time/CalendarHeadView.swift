//
//  CalendarHeadView.swift
//  Chamber Time
//
//  Created by YangYueyang on 16/5/23.
//  Copyright © 2016年 NJU. All rights reserved.
//

import UIKit
/* 
            head view
 ----------------------------
 |         2016.05           |
 | 日  一  二  三  四  五  六  |
 -----------------------------
 
*/


class CalendarHeadView: UIView {
    var titleLabel : UILabel!
    let weekArray = ["日","一","二","三","四","五","六"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
        for title in weekArray {
            self.createLabel(title)
        }
        let title = UILabel()
        //得到格式化的今年份与月份，  2016.05
        title.text = NSDate().getFormatDate()
        title.textAlignment = .Center
        self.addSubview(title)
        self.titleLabel = title
    }
    
    func createLabel(name : String) {
        let label = UILabel()
        label.text = name
        //label.font = UIFont.fontWithSize(13)
        label.textColor = UIColor(red: 100/255.0, green: 100/255.0, blue: 200/255.0, alpha: 1.0)
        label.textAlignment = .Center
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        //let count = self.subviews.count
        //let W = self.frame.size.width / CGFloat(count-1)
        //计算每一个“一” 、 “二” 的宽度
        let weekLabelWidth = self.frame.size.width / CGFloat(7)
        
        var i = 0;
        for view in self.subviews {
            if view == self.titleLabel {
                view.frame.size.width = self.frame.size.width
                view.frame.size.height = self.frame.size.height/2
            } else {
                view.frame.size.width = weekLabelWidth
                view.frame.size.height = self.frame.size.height/2
                view.frame.origin.x = weekLabelWidth * CGFloat(i)
                view.frame.origin.y = 25
            }
            i += 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
