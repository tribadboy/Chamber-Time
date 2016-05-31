//
//  CalendarContentView.swift
//  Chamber Time
//
//  Created by YangYueyang on 16/5/24.
//  Copyright © 2016年 NJU. All rights reserved.
//


import UIKit
protocol CalendarContentViewDelegate {
    
    func calendarContentViewCurrentDate(date : NSDate)
    func calendarContemViewSelectDate(year:Int,month:Int,day:Int)
    
}
class CalendarContentView: UIView,UICollectionViewDataSource,UICollectionViewDelegate,CalendarCellDelegate {
    
    var MothLenght = 0
    var MothFirstDay = 0
    var dataArr = NSMutableArray()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
        getData(NSDate())
        
    }
    func getData(date : NSDate) {
        self.dataArr.removeAllObjects()
        self.dataArr.addObjectsFromArray(NSDate.getRecentDate(date) as [AnyObject])
        let currentIndexPathReset = NSIndexPath(forItem: 2, inSection: 0)
        self.collectionView.scrollToItemAtIndexPath(currentIndexPathReset, atScrollPosition: .Left, animated: false)
        self.delegate?.calendarContentViewCurrentDate(self.dataArr[2] as! NSDate)
        self.collectionView.reloadData()
    }
    // MARK: collection代理
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CalendarCell", forIndexPath: indexPath) as! CalendarCell
        let date = self.dataArr[indexPath.row] as! NSDate
        cell.date = date
        cell.delegate = self
        
        return cell
    }
    func CalendarCellSelectDate(year: Int, month: Int, day: Int) {
        let date = self.dataArr[2] as! NSDate
        let mon = date.getMonth()
        let yea = date.getYear()
        if yea*100+mon > year*100+month {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0)
                , atScrollPosition: .Left, animated: true)
        } else if yea*100+mon < year*100+month  {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 3, inSection: 0)
                , atScrollPosition: .Left, animated: true)
        }
        self.delegate?.calendarContemViewSelectDate(year, month: month, day: day)
    }
    // MARK: scroll代理
    /**当用户即将开始拖拽的时候就调用*/
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        print("scrollViewDidEndDragging--开始")
    }
    /**当用户停止拖拽的时候就调用*/
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging--松开")
    }
    /**停止滚动的时候*/
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/self.bounds.size.width)
        print(index)
        self.getData(self.resetIndexPath(index))
    }
    /**动画听海的时候 */
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation--结束")
        let index = Int(scrollView.contentOffset.x/self.bounds.size.width)
        self.getData(self.resetIndexPath(index))
    }
    func resetIndexPath(index : Int) -> NSDate {
        return self.dataArr[index] as! NSDate;
    }
    //MARK: 布局
    override func layoutSubviews() {
        self.collectionView.frame = self.bounds
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        let currentIndexPathReset = NSIndexPath(forItem: 2, inSection: 0)
        self.collectionView.scrollToItemAtIndexPath(currentIndexPathReset, atScrollPosition: .Left, animated: false)
    }
    // MARK: 懒加载
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        view.delegate = self;
        view.dataSource=self;
        // 注册cell
        view.registerNib(UINib(nibName: "CalendarCell", bundle:nil), forCellWithReuseIdentifier: "CalendarCell")
        view.pagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor.whiteColor()
        layout.scrollDirection = .Horizontal
        layout.minimumInteritemSpacing=0
        layout.minimumLineSpacing=0
        
        return view
    }()
    var delegate : CalendarContentViewDelegate?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}