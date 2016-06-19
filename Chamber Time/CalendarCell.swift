//
//  CalendarCell.swift
//  Chamber Time
//
//  Created by YangYueyang on 16/6/20.
//  Copyright © 2016年 NJU. All rights reserved.
//

import UIKit
protocol CalendarCellDelegate {
    func CalendarCellSelectDate(year:Int,month:Int,day:Int)
}

let selectDate = "selectDate"

class CalendarCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    //MARK: 属性
    var MothLenght = 0
    var MothFirstDay = 0
    var delegate : CalendarCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(self.collectionView)
        
    }
    var date : NSDate? {
        didSet {
            getData(date!)
        }
    }
    func getData(date : NSDate) {
        self.MothFirstDay = date.getMontFirstWeekDay()
        self.MothLenght = date.getMonthHowManyDay()
        self.collectionView.reloadData()
    }
    // MARK: collection代理
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CalendarItemCell", forIndexPath: indexPath) as! CalendarItemCell
        if indexPath.row >= self.MothFirstDay && indexPath.row <= self.MothLenght+self.MothFirstDay-1 {
            cell.date = date
            cell.day = indexPath.row - self.MothFirstDay + 1
            
            
            
            //如果当天存在任务，将label的背景颜色高亮 本月
            if tasks?.count > 0 {
                for index in 0...((tasks?.count)!-1) {
                    let taskDate = tasks?.objectAtIndex(index).date
                    if date?.getYear() == taskDate?.getYear() && date?.getMonth() == taskDate?.getMonth()
                        && cell.day == taskDate?.getDay() {
                        cell.bgView.backgroundColor = UIColor(red: 240/255.0, green: 220/255.0, blue: 200/255.0, alpha: 1.0)
                        break
                    }
                    
                }
                //cell.bgView.backgroundColor = UIColor.grayColor()
            }
            
            
            
        } else if indexPath.row < self.MothFirstDay{
            cell.date = date
            cell.day = date!.getLastDateLenght() - self.MothFirstDay + indexPath.row + 1
            cell.label.textColor = UIColor.grayColor()
            cell.bgView.backgroundColor = UIColor.whiteColor()
            
            
        } else {
            cell.date = date
            cell.day = indexPath.row - self.MothLenght - self.MothFirstDay + 1
            cell.label.textColor = UIColor.grayColor()
            cell.bgView.backgroundColor = UIColor.whiteColor()
            
        }
        
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CalendarItemCell
        if indexPath.row >= self.MothFirstDay && indexPath.row <= self.MothLenght+self.MothFirstDay-1 {
            let day = Int(cell.label.text!)
            let time = cell.date!.getDateY_M_D(day!)
            NSUserDefaults.standardUserDefaults().setObject(cell.date?.getDate(day!), forKey: selectDate)
            self.delegate?.CalendarCellSelectDate(time.0, month: time.1, day: time.2)
            collectionView.reloadData()
            
        } else if indexPath.row < self.MothFirstDay{
            let day = Int(cell.label.text!)
            let time = date!.getLastDate().getDateY_M_D(day!)
            NSUserDefaults.standardUserDefaults().setObject(date?.getLastDate().getDate(day!), forKey: selectDate)
            self.delegate?.CalendarCellSelectDate(time.0, month: time.1, day: time.2)
        } else {
            let day = Int(cell.label.text!)
            let time = date!.getNextDate().getDateY_M_D(day!)
            NSUserDefaults.standardUserDefaults().setObject(date?.getNextDate().getDate(day!), forKey: selectDate)
            self.delegate?.CalendarCellSelectDate(time.0, month: time.1, day: time.2)
        }
        
    }
    //MARK: 布局
    override func layoutSubviews() {
        self.collectionView.frame = self.bounds
        let W : CGFloat = (self.bounds.size.width-7)/7
        let H : CGFloat = (self.bounds.size.height-6)/6
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSizeMake(W, H);
    }
    // MARK: 懒加载
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        view.delegate = self;
        view.dataSource=self;
        // 注册cell
        view.registerNib(UINib(nibName: "CalendarItemCell", bundle:nil), forCellWithReuseIdentifier: "CalendarItemCell")
        view.pagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1.0)
        layout.scrollDirection = .Vertical
        layout.minimumInteritemSpacing=1
        layout.minimumLineSpacing=1
        return view
    }()
    
    
}