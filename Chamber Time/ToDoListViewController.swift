//
//  ToDoListViewController.swift
//  Chamber Time
//
//  Created by YangYueyang on 16/5/24.
//  Copyright © 2016年 NJU. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    //@IBOutlet weak var myTapGesture: UITapGestureRecognizer!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath)
        
        // Configure the cell...
        //cell.textLabel?.text = foodList[indexPath.row]
        let task = tasks[indexPath.row] as ToDoTask
        
        let imageView = cell.viewWithTag(101) as! UIImageView
        let title = cell.viewWithTag(102) as! UILabel
        let date = cell.viewWithTag(103) as! UILabel
        
        imageView.image = UIImage(named: task.imageId)
        title.text = task.title
        
        let dateFormat = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: nil)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        date.text = dateFormatter.stringFromDate(task.date)
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            tasks.removeAtIndex(indexPath.row)
            //tableView.reloadData()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    @IBAction func exitToList(sender: UIStoryboardSegue) {
        print("closed")
        let newTask: ToDoTask? = (sender.sourceViewController as? TaskDetailViewController)?.newTask
        
        if newTask != nil {
            tasks.append(newTask!)
            self.tableview.reloadData()
        }
        
    }
    

}


