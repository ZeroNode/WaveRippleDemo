//
//  ViewController.swift
//  TeacherAttendance
//
//  Created by mc on 29/12/2016.
//  Copyright © 2016 mc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var rippleView:YNRippleAnimatView!
    var timer:NSTimer!
    var maxRadius:CGFloat!
    var isok = false
    var resetBtn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        resetBtn = UIButton(frame: CGRectMake((UIScreen.mainScreen().bounds.size.width - 80)/2, maxRadius*2, 80, 30))
        resetBtn.backgroundColor = UIColor.brownColor()
        resetBtn.setTitle("重置", forState: UIControlState.Normal)
        resetBtn.addTarget(self, action: #selector(self.reset), forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(resetBtn)
        
    }
    
    func initView(){
        // 扩散水波纹
        maxRadius = UIScreen.mainScreen().bounds.size.width * 0.4
        rippleView = YNRippleAnimatView(minRadius: 40, maxRadius: maxRadius)
        rippleView.rippleCount = 5
        rippleView.rippleDuration = 4
        rippleView.backgroundColor = UIColor(red: 114/255, green: 187/255, blue: 56/255, alpha: 1)
        rippleView.imageSize = CGSize(width: maxRadius, height: maxRadius)
        rippleView.textlabel.text = "签到"
        rippleView.textlabel.textColor = UIColor.whiteColor()
        rippleView.textlabel.font = UIFont.systemFontOfSize(15)
        
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action:
        #selector(self.clickBtn))
        rippleView.addGestureRecognizer(tapGestureRecognizer)
        rippleView.rippleColor = UIColor.clearColor()
        rippleView.borderWidth = 2
        rippleView.borderColor = UIColor(red: 114/255, green: 187/255, blue: 56/255, alpha: 1)
        let x:CGFloat  = (UIScreen.mainScreen().bounds.size.width-maxRadius)/2
        rippleView.frame = CGRect(x: x, y: maxRadius/2, width: maxRadius, height: maxRadius)
        self.view.addSubview(rippleView)
    }
    
    /**
     *计时器每秒触发事件
     **/
    func tickDown(){
        rippleView.timelabel.text = CommUtils.sharedInstance.getStringWithDate(NSDate(), format: dateFormat.HHmmss)
    }
    
    //打开定时器
    func openTimer(){
        if timer == nil{
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector:#selector(self.tickDown), userInfo: nil, repeats: true)
            timer.fireDate = NSDate.distantPast()
        }
    }
    
    //关闭定时器
    func closeTimer(){
        if timer != nil {
            timer.fireDate = NSDate.distantFuture()
            timer.invalidate()
            timer = nil
        }
    }
    
    func clickBtn(){
        // 关闭定时器
        self.closeTimer()
        self.rippleView.stopAnimation()
        self.isok = true
        //签到
        self.rippleView.textlabel.text = "已签到"
        self.rippleView.textlabel.font = UIFont.systemFontOfSize(15)
        self.rippleView.userInteractionEnabled = false
    }
    
    func reset(){
        if self.isok{
            if rippleView != nil{
                self.rippleView.startAnimation()
                self.openTimer()
            }
        }
        self.isok = false
        //签到
        self.rippleView.textlabel.text = "签到"
        self.rippleView.textlabel.font = UIFont.systemFontOfSize(15)
        self.rippleView.userInteractionEnabled = true
    }
    
    override func viewWillAppear(animated: Bool) {
        // 进入后台
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(appwillResignActive(_:)), name: UIApplicationWillResignActiveNotification, object: nil)
        // 从后台进入活动状态
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(appBecomeActive(_:)), name: UIApplicationDidBecomeActiveNotification, object: nil)
        
    }
    
    //将要进入后台
    func appwillResignActive(sender:NSNotification?){
        // 停止动画
        if !self.isok {
            if rippleView != nil{
                rippleView.stopAnimation()
            }
            // 关闭定时器
            closeTimer()
        }
    }
    
    //已经从后台进入前台
    func appBecomeActive(sender:NSNotification?){
        // 开始动画
        if !self.isok {
            if rippleView != nil{
                rippleView.startAnimation()
            }
            // 打开定时器
            openTimer()
        }
    }
    //视图出现执行
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(true)
//        if !self.isok {
//            rippleView.startAnimation()
//            // 打开定时器
//            openTimer()
//        }
//    }
//    //视图消失执行
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(true)
//        self.rippleView.stopAnimation()
//        self.closeTimer()
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

