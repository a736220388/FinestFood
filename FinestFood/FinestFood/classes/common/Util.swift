//
//  Util.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

public enum FoodListType:Int{
    case Shopping = 12
    case Course = 13
    case Tour = 14
    case Eating = 15
    case DIYCourse = 16
    case DIYCooking = 17
    case Moiving = 18
}
class Util: NSObject {
    class func animationWith(view:UIView){
        UIView.beginAnimations("animate", context: nil)
        UIView.setAnimationDuration(1)
        UIView.setAnimationRepeatCount(1)
        UIView.setAnimationDelegate(self)
        
        UIView.commitAnimations()
    }

    class func CaculateWeekDay(dateStr:String) ->String{
        let dateArr = dateStr.componentsSeparatedByString("-")
        if dateArr.count == 3{
            var y = Int(dateArr[0])!
            var m = Int(dateArr[1])!
            let d = Int(dateArr[2])!
            if m == 1 || m == 2{
                m += 12
                y -= 1
            }
            let iWeek = (d+2*m+3*(m+1)/5+y+y/4-y/100+y/400)%7
            switch iWeek{
            case 0: return "星期一"
            case 1: return "星期二"
            case 2: return "星期三"
            case 3: return "星期四"
            case 4: return "星期五"
            case 5: return "星期六"
            case 6: return "星期天"
            default:
                return ""
            }
        }else{
            return "星期未知"
        }
    }
    
    class func createLabel(frame:CGRect,text:String?)->UILabel{
        let label = UILabel(frame: frame)
        if text != nil {
            label.text = text!
            label.textAlignment = .Left
            label.font = UIFont.systemFontOfSize(17)
        }
        return label
    }
    class func createTextField(frame:CGRect,text:String?)->UITextField{
        let txtField = UITextField(frame: frame)
        txtField.keyboardType = .EmailAddress
        //txtField.borderStyle = .RoundedRect
        if text != nil {
            txtField.placeholder = text
        }
        txtField.clearButtonMode = .Always
        return txtField
    }
    
    
    class func createBtn(frame:CGRect,title:String?,target:AnyObject?,action:Selector?)->UIButton{
        let btn = UIButton(type: .System)
        btn.frame = frame
        if title != nil{
            btn.setTitle(title, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(20)
        }
        if target != nil && action != nil {
            btn.addTarget(target, action: action!, forControlEvents: .TouchUpInside)
        }
        return btn
    }
    class func showAlertWithOK(viewCtrl:UIViewController, msg:String,completeClosure:((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: "温馨提示", message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "确定", style: .Default, handler: completeClosure)
        alert.addAction(action)
        viewCtrl.presentViewController(alert, animated: true, completion: nil)
    }
    class func showAlertWithOKAndCancle(viewCtrl:UIViewController,msg:String,completeClosure:((UIAlertAction) -> Void)?,cancleClosure:((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: "温馨提示", message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "确定", style: .Default, handler: completeClosure)
        let action1 = UIAlertAction(title: "取消", style: .Cancel, handler: cancleClosure)
        alert.addAction(action)
        alert.addAction(action1)
        viewCtrl.presentViewController(alert, animated: true, completion: nil)
    }

}

