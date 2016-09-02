//
//  MineLoginViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MineLoginViewController: HomeTarbarViewController {
    var phoneTxtField:UITextField?
    var passwordTxtField:UITextField?
    var loginBtn:UIButton?
    var forgetBtn:UIButton?
    var loginByQQBun:UIButton?
    var loginByWeixinBtn:UIButton?
    var convertUserInfoClosure:((UserInfoModel)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.whiteColor()
        navigationController?.navigationBarHidden = false
        createLoginInterface()
        title = "我的"
        let btn = UIButton.createBtn("注册", bgImageName: nil, selectBgImageName: nil, target: self, action: #selector(registerAction))
        btn.frame = CGRectMake(0, 4, 80, 20)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }
    func registerAction(){
        let registerCtrl = MineRegisterViewController()
        navigationController?.pushViewController(registerCtrl, animated: true)
    }
    func createLoginInterface(){
        let phoneLabel = Util.createLabel(CGRectMake(15, kScreenHeight/2-134, 80, 40), text: "手机号:")
        let passwordLabel = Util.createLabel(CGRectMake(15, kScreenHeight/2-84, 80, 40), text: "密    码:")
        let lineLebelOne = Util.createLabel(CGRectMake(15, kScreenHeight/2-45, kScreenWidth-30, 1), text: nil)
        lineLebelOne.backgroundColor = UIColor.grayColor()
        view.addSubview(lineLebelOne)
        let lineLebelTwo = Util.createLabel(CGRectMake(15, kScreenHeight/2-95, kScreenWidth-30, 1), text: nil)
        lineLebelTwo.backgroundColor = UIColor.grayColor()
        view.addSubview(lineLebelTwo)
        
        view.addSubview(phoneLabel)
        view.addSubview(passwordLabel)
        
        phoneTxtField = Util.createTextField(CGRectMake(80, kScreenHeight/2-128, kScreenWidth-100, 30),text: "请输入手机号")
        passwordTxtField = Util.createTextField(CGRectMake(80, kScreenHeight/2-78, kScreenWidth-100, 30),text: "请输入密码")
        passwordTxtField?.secureTextEntry = true
        view.addSubview(phoneTxtField!)
        view.addSubview(passwordTxtField!)
        phoneTxtField?.delegate = self
        passwordTxtField?.delegate = self
        
        loginBtn = Util.createBtn(CGRectMake(15, kScreenHeight/2, kScreenWidth-30, 40), title: "登陆", target: self, action: #selector(loginAction))
        loginBtn!.backgroundColor = UIColor.greenColor()
        loginBtn!.alpha = 0.3
        loginBtn!.layer.cornerRadius = 5
        loginBtn!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        view.addSubview(loginBtn!)
        
        let problemBtn = Util.createBtn(CGRectMake(kScreenWidth/2+20, kScreenHeight/2 + 40, kScreenWidth/2-15, 30), title: "登陆遇到问题?", target: self, action: #selector(problemAction))
        problemBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        problemBtn.alpha = 0.5
        problemBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        view.addSubview(problemBtn)
    }
    func loginAction(){
        if phoneTxtField?.text != "" && passwordTxtField?.text != ""{
            let downloader = MyDownloader()
            let paramString = "mobile=\((phoneTxtField?.text)!)&password=\((passwordTxtField?.text)!)"
            downloader.downloadWithPostUrlString(MineLoginUrl, paramString: paramString)
            downloader.didFailWithError = {
                error in
                print(error.description)
            }
            downloader.didFinishWithData = {
                data in
                let jsonData = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
                if jsonData.isKindOfClass(NSDictionary.self){
                    let dict = jsonData as! Dictionary<String,AnyObject>
                    if (dict["code"] as! NSNumber) == 400{
                        dispatch_async(dispatch_get_main_queue(), {
                            [weak self] in
                            Util.showAlertWithOK(self!, msg: "手机号码或者密码输入错误!", completeClosure: nil)
                        })
                    }else if (dict["code"] as! NSNumber) == 200{
                        /*登录成功后返回的数据:
                         {
                         "code": 200,
                         "data": {
                         "avatar_url": "",
                         "can_mobile_login": true,
                         "guest_uuid": null,
                         "id": 5008184,
                         "mobile": "18550217032", 
                         "nickname": "18550217032", 
                         "role": 0
                         }, 
                         "message": "OK"
                         }
                         */
                        let dataDict = dict["data"] as! Dictionary<String,AnyObject>
                        let userInfoModel = UserInfoModel()
                        userInfoModel.setValuesForKeysWithDictionary(dataDict)
                        self.convertUserInfoClosure!(userInfoModel)
                        dispatch_async(dispatch_get_main_queue(), {
                            [weak self] in
                            Util.showAlertWithOK(self!, msg: "登录成功", completeClosure: { (action) in
                                self?.navigationController?.popViewControllerAnimated(true)
                            })
                        })
                    }
                }
            }
        }else{
            Util.showAlertWithOK(self, msg: "请输入完整的手机号和密码", completeClosure: nil)
        }
    }
    func problemAction(){
        
    }
}

extension MineLoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.phoneTxtField{
            self.phoneTxtField?.resignFirstResponder()
            self.passwordTxtField?.becomeFirstResponder()
        }else if textField == self.passwordTxtField{
            self.passwordTxtField?.resignFirstResponder()
        }
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        if phoneTxtField?.text != "" && phoneTxtField?.text != ""{
            loginBtn?.alpha = 1
        }else{
            loginBtn?.alpha = 0.3
        }
    }
}
