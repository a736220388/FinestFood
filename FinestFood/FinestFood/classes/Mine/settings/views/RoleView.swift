//
//  RoleView.swift
//  FinestFood
//
//  Created by qianfeng on 16/9/1.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class RoleView: UIView {

    var bgView:UIView?
    
    var genderView:UIView?
    
    var roleView:UIView?
    
    var maleBtn:UIButton?
    var femaleBtn:UIButton?
    
    var roleClosure:((Int,String)->Void)?
    
    let rolesArray = ["初中生","高中生","大学生","职场新人","资深工作党"]
    
    var offsetY = kScreenHeight/2-120
    var offsetX = kScreenWidth/2-120
    var viewWidth = 240
    
    init(){
        super.init(frame: CGRectZero)
        bgView = UIView.createUIView()
        addSubview(bgView!)
        bgView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!)
        })
        bgView?.backgroundColor = UIColor.blackColor()
        bgView?.alpha = 0.5
        
        createGenderView()
        
        createRoleView()
        
    }
    func createRoleView(){
        roleView = UIView.createUIView()
        roleView?.backgroundColor = UIColor.whiteColor()
        addSubview(roleView!)
        roleView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.width.height.equalTo(self!.viewWidth)
            make.top.equalTo(self!).offset(-self!.offsetY*2)
            make.left.equalTo(self!).offset(self!.offsetX)
        })
        let cancelBtn = UIButton.createBtn(nil, bgImageName: "cancel.png", selectBgImageName: nil, target: self, action: #selector(cancelAction))
        roleView?.addSubview(cancelBtn)
        cancelBtn.snp_makeConstraints { (make) in
            make.top.equalTo(roleView!).offset(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.left.equalTo(roleView!).offset(210)
        }
        let backBtn = UIButton.createBtn(nil, bgImageName: "back.png", selectBgImageName: nil, target: self, action: #selector(backAction))
        roleView?.addSubview(backBtn)
        backBtn.snp_makeConstraints { (make) in
            make.top.equalTo(roleView!).offset(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.left.equalTo(roleView!).offset(10)
        }
        
        for i in 0..<5{
            let roleBtn = UIButton.createBtn(nil, bgImageName: "point.png", selectBgImageName: "pointselected.png", target: self, action: #selector(roleOptionAction(_:)))
            roleBtn.tag = 430+i
            if i==3 {
                roleBtn.selected = true
            }
            roleView?.addSubview(roleBtn)
            roleBtn.snp_makeConstraints { (make) in
                make.top.equalTo(roleView!).offset(50+i*30)
                make.width.equalTo(20)
                make.height.equalTo(20)
                make.left.equalTo(roleView!).offset(200)
            }
            let roleLabel = UILabel.createLabel(rolesArray[i], font: UIFont.systemFontOfSize(17), textAlignment: .Left, textColor: UIColor.blackColor())
            roleView?.addSubview(roleLabel)
            roleLabel.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(roleView!).offset(50+i*30)
                make.width.equalTo(120)
                make.height.equalTo(20)
                make.left.equalTo(roleView!).offset(20)
            })
        }
        
        let finishBtn = UIButton.createBtn("完成", bgImageName: nil, selectBgImageName: nil, target: self, action: #selector(finishAction))
        finishBtn.backgroundColor = UIColor.orangeColor()
        finishBtn.layer.cornerRadius = 8
        finishBtn.clipsToBounds = true
        roleView?.addSubview(finishBtn)
        finishBtn.snp_makeConstraints { (make) in
            make.top.equalTo(roleView!).offset(200)
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.left.equalTo(roleView!).offset(60)
        }
        
    }
    func createGenderView(){
        genderView = UIView.createUIView()
        genderView?.backgroundColor = UIColor.whiteColor()
        addSubview(genderView!)
        genderView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.width.height.equalTo(self!.viewWidth)
            make.top.equalTo(self!).offset(self!.offsetY)
            make.left.equalTo(self!).offset(self!.offsetX)
        })
        let titleLabel = UILabel.createLabel("选择性别", font: UIFont.systemFontOfSize(17), textAlignment: .Center, textColor: UIColor.blackColor())
        genderView?.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(genderView!).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(20)
            make.left.equalTo(genderView!).offset(80)
        }
        let maleImage = UIImageView.createImageView("male.png")
        genderView?.addSubview(maleImage)
        maleImage.snp_makeConstraints { (make) in
            make.top.equalTo(genderView!).offset(50)
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.left.equalTo(genderView!).offset(40)
        }
        let femaleImage = UIImageView.createImageView("female.png")
        genderView?.addSubview(femaleImage)
        femaleImage.snp_makeConstraints { (make) in
            make.top.equalTo(genderView!).offset(50)
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.left.equalTo(genderView!).offset(140)
        }
        maleBtn = UIButton.createBtn(nil, bgImageName: "point.png", selectBgImageName: "pointselected.png", target: self, action: #selector(genderOptionAction(_:)))
        femaleBtn = UIButton.createBtn(nil, bgImageName: "point.png", selectBgImageName: "pointselected.png", target: self, action: #selector(genderOptionAction(_:)))
        maleBtn?.tag = 330
        femaleBtn?.tag = 331
        genderView?.addSubview(maleBtn!)
        genderView?.addSubview(femaleBtn!)
        maleBtn!.selected = true
        maleBtn!.snp_makeConstraints { (make) in
            make.top.equalTo(genderView!).offset(130)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.left.equalTo(genderView!).offset(60)
        }
        femaleBtn!.snp_makeConstraints { (make) in
            make.top.equalTo(genderView!).offset(130)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.left.equalTo(genderView!).offset(160)
        }
        let nextStepBtn = UIButton.createBtn("下一步", bgImageName: nil, selectBgImageName: nil, target: self, action: #selector(nextStepAction))
        nextStepBtn.backgroundColor = UIColor.orangeColor()
        nextStepBtn.layer.cornerRadius = 8
        nextStepBtn.clipsToBounds = true
        genderView?.addSubview(nextStepBtn)
        nextStepBtn.snp_makeConstraints { (make) in
            make.top.equalTo(genderView!).offset(180)
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.left.equalTo(genderView!).offset(60)
        }
        let cancelBtn = UIButton.createBtn(nil, bgImageName: "cancel.png", selectBgImageName: nil, target: self, action: #selector(cancelAction))
        genderView?.addSubview(cancelBtn)
        cancelBtn.snp_makeConstraints { (make) in
            make.top.equalTo(genderView!).offset(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.left.equalTo(genderView!).offset(210)
        }
    }
    func genderOptionAction(btn:UIButton){
        if btn.tag == 330{
            if btn.selected {
                btn.selected = false
                femaleBtn?.selected = true
            }else{
                btn.selected = true
                femaleBtn?.selected = false
            }
        }else if btn.tag == 331{
            if btn.selected {
                btn.selected = false
                maleBtn?.selected = true
            }else{
                btn.selected = true
                maleBtn?.selected = false
            }
        }
        
    }
    func nextStepAction(){
        UIView.beginAnimations("animate", context: nil)
        UIView.setAnimationDuration(0.2)
        UIView.setAnimationRepeatCount(1)
        UIView.setAnimationDelegate(self)
        roleView?.frame.origin.y += 3*offsetY
        genderView?.frame.origin.y += 4*offsetY
        UIView.commitAnimations()
    }
    func roleOptionAction(btn:UIButton){
        for subView in (btn.superview?.subviews)!{
            if subView.isKindOfClass(UIButton.self){
                let tmpBtn = subView as! UIButton
                tmpBtn.selected = false
            }
        }
        btn.selected = true
        
    }
    func backAction(){
        UIView.beginAnimations("animate", context: nil)
        UIView.setAnimationDuration(0.2)
        UIView.setAnimationRepeatCount(1)
        UIView.setAnimationDelegate(self)
        roleView?.frame.origin.y -= 3*offsetY
        genderView?.frame.origin.y -= 4*offsetY
        UIView.commitAnimations()
    }
    func cancelAction(){
        self.hidden = true
    }
    func finishAction(){
        self.hidden = true
        var gender = 0
        var role = ""
        for subView in (genderView?.subviews)!{
            if subView.isKindOfClass(UIButton.self) {
                let tmpBtn = subView as! UIButton
                if tmpBtn.selected == true{
                    gender = tmpBtn.tag - 330
                }
            }
        }
        for subView in (roleView?.subviews)! {
            if subView.isKindOfClass(UIButton.self){
                let tmpBtn = subView as! UIButton
                if tmpBtn.selected == true{
                    role = rolesArray[tmpBtn.tag - 430]
                }
            }
        }
        self.roleClosure!(gender,role)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
