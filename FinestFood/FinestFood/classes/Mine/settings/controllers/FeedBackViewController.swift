//
//  FeedBackViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/9/1.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FeedBackViewController: BaseViewController {
    
    var btn:UIButton?
    var contentTextView = UITextView()
    var contactTextView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn = UIButton.createBtn("完成", bgImageName: nil, selectBgImageName: nil, target: self, action: #selector(finishEditAction))
        btn?.frame = CGRectMake(0, 0, 60, 30)
        btn?.setTitleColor(UIColor.grayColor(), forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn!)
        
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        let contentLabel = UILabel.createLabel("反馈内容", font: UIFont.systemFontOfSize(17), textAlignment: .Left, textColor: UIColor.blackColor())
        view.addSubview(contentLabel)
        contentLabel.snp_makeConstraints {
            [weak self]
            (make) in
            make.left.right.equalTo(self!.view).offset(10)
            make.top.equalTo(self!.view).offset(80)
            make.height.equalTo(30)
        }

        contentTextView.text = "我们很需要你的意见和建议~"
        contentTextView.font = UIFont.systemFontOfSize(17)
        contentTextView.textColor = UIColor.grayColor()
        contentTextView.backgroundColor = UIColor.whiteColor()
        contentTextView.delegate = self
        contentTextView.tag = 120
        view.addSubview(contentTextView)
        contentTextView.snp_makeConstraints {
            [weak self]
            (make) in
            make.left.right.equalTo(self!.view)
            make.top.equalTo(contentLabel.snp_bottom).offset(10)
            make.height.equalTo(150)
        }
        let contactLabel = UILabel.createLabel("联系方式", font: UIFont.systemFontOfSize(17), textAlignment: .Left, textColor: UIColor.blackColor())
        self.view.addSubview(contactLabel)
        contactLabel.snp_makeConstraints {
            [weak self]
            (make) in
            make.left.right.equalTo(self!.view).offset(10)
            make.top.equalTo(self!.contentTextView.snp_bottom).offset(20)
            make.height.equalTo(30)
        }
        
        contactTextView.text = "电话/邮箱/QQ"
        contactTextView.font = UIFont.systemFontOfSize(17)
        contactTextView.textColor = UIColor.grayColor()
        contactTextView.backgroundColor = UIColor.whiteColor()
        contactTextView.delegate = self
        contactTextView.tag = 121
        self.view.addSubview(contactTextView)
        contactTextView.snp_makeConstraints {
            [weak self]
            (make) in
            make.left.right.equalTo(self!.view)
            make.top.equalTo(contactLabel.snp_bottom).offset(10)
            make.height.equalTo(35)
        }

    }
    func finishEditAction(){
        self.navigationController?.popViewControllerAnimated(true)
        print("上传建议")
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
extension FeedBackViewController:UITextViewDelegate{
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == "我们很需要你的意见和建议~" || textView.text == "电话/邮箱/QQ" {
            textView.text = ""
        }
        textView.textColor = UIColor.blackColor()
    }
    func textViewDidEndEditing(textView: UITextView) {
        if textView.tag == 120 && textView.text == ""{
            textView.text = "我们很需要你的意见和建议~"
            textView.textColor = UIColor.grayColor()
        }else if textView.tag == 121 && textView.text == ""{
            textView.text = "电话/邮箱/QQ"
            textView.textColor = UIColor.grayColor()
        }
        
    }
    func textViewDidChange(textView: UITextView) {
        if textView.text != "" {
            self.btn?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        }else{
            self.btn?.setTitleColor(UIColor.grayColor(), forState: .Normal)
        }
    }
}
