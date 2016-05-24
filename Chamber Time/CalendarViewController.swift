//
//  CalendarViewController.swift
//  Chamber Time
//
//  Created by YangYueyang on 16/5/10.
//  Copyright © 2016年 NJU. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController ,CalendarViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = CalendarView()
        view.frame = CGRectMake(0, 100, self.view.bounds.size.width, 250)
        //view.titleColor = UIColor.blueColor()
        view.delegate = self
        self.view.addSubview(view)
        
        // CalendarView.show(self.view, frame: CGRectMake(0, 100, self.view.bounds.size.width, 250)) { (year, month, day) -> Void in
        //      print("\(year)-\(month)-\(day)")
        //}
    }
    //点击选择日期功能
    func CalendarViewSelectDate(year: Int, month: Int, day: Int) {
        print("\(year)-\(month)-\(day)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
