//
//  TaskDetailViewController.swift
//  Chamber Time
//
//  Created by YangYueyang on 16/5/24.
//  Copyright © 2016年 NJU. All rights reserved.
//

import UIKit



class TaskDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBAction func xuexiTapped(sender: UIButton) {
        typeNameLabel.text = "学习"
    }
    
    @IBAction func jujjiaTapped(sender: UIButton) {
        typeNameLabel.text = "居家"
    }
    
    @IBAction func diannaoTapped(sender: UIButton) {
        typeNameLabel.text = "电脑"
    }
    
    @IBAction func lvxingTapped(sender: UIButton) {
        typeNameLabel.text = "旅行"
    }

    @IBAction func gongzuoTapped(sender: UIButton) {
        typeNameLabel.text = "工作"
    }
    
    @IBAction func yuleTapped(sender: UIButton) {
        typeNameLabel.text = "娱乐"
    }
    
    @IBAction func dianhuaTapped(sender: UIButton) {
        typeNameLabel.text = "电话"
    }
    
    @IBAction func yuehuiTapped(sender: UIButton) {
        typeNameLabel.text = "约会"
    }
    
    @IBOutlet weak var typeNameLabel: UILabel!
    
    @IBOutlet weak var task: UITextField!
    
    @IBOutlet weak var date: UIDatePicker!
    
    @IBOutlet weak var desp: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var newTask: ToDoTask?
    //var newTaskFlag: Bool = true
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(sender === saveButton){
            if(newTask == nil) {        //创建一个新任务并保存
                let id = NSUUID().UUIDString
                let imageId = typeNameLabel.text
                let title = task.text
                let taskDate = date.date
                let taskDesc = desp.text
                newTask = ToDoTask(id: id, imageId: imageId!, title: title!, date: taskDate, desc: taskDesc)
                //tasks!.append(newTask!)
                tasks!.addObject(newTask!)
                print(tasks!.count)
            }
            else {                      //对原有任务修改并保存
                newTask?.imageId = typeNameLabel.text!
                newTask?.title = task.text!
                newTask?.date = date.date
                newTask!.desc = desp.text
                print(tasks!.count)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        task.delegate = self
        desp.delegate = self
        
        if(newTask == nil) {
            navigationItem.title = "新建任务"
            typeNameLabel.text = "工作"
            task.text = "任务标题"
            date.date = NSDate()
            desp.text = "请输入任务简介"
            //newTaskFlag = true
            
        }
        else {
            navigationItem.title = "修改任务"
            typeNameLabel.text = String(newTask!.imageId)
            task.text = String(newTask!.title)
            date.setDate((newTask!.date)!, animated: false)
            desp.text = String(newTask!.desc)
            //newTaskFlag = false
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //textField 键盘return后消失
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //点击其他地方，键盘消失
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        task.resignFirstResponder()
        desp.resignFirstResponder()
    }
    
    //textView被编辑前，视图总框架上移
    func textViewDidBeginEditing(textView: UITextView) {
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame.origin.y = -250
        })
    }
    
    //textView结束编辑后，视图总框架恢复原位置
    func textViewDidEndEditing(textView: UITextView) {
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame.origin.y = 0
        })
    }
    
    
    //textView 在键盘中输入return后，键盘消失
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
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
