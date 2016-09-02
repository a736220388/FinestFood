//
//  MainTabBarController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var bgView:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createViewControllers()
        createTabBar()
        tabBar.hidden = true
    }
    func createViewControllers(){
        let ctrlNames = ["FoodSubjectViewController","FoodListViewController","CategoryViewController","MoreViewController","MineViewController"]
        var array = Array<UINavigationController>()
        for i in 0..<ctrlNames.count{
            let str = "FinestFood." + ctrlNames[i]
            let ctrlClass = NSClassFromString(str) as! UIViewController.Type
            let ctrl = ctrlClass.init()
            let navCtrl = UINavigationController(rootViewController: ctrl)
            array.append(navCtrl)
        }
        self.viewControllers = array
    }
    func createTabBar(){
        let imageNames = ["home","community","shop","shike","mine"]
        let titleNames = ["主题","专题","分类","更多","我的"]
        bgView = UIView()
        bgView?.backgroundColor = UIColor.whiteColor()
        bgView?.layer.borderWidth = 1
        bgView?.layer.borderColor = UIColor.grayColor().CGColor
        view.addSubview(bgView!)
        bgView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.left.right.equalTo((self?.view)!)
            make.top.equalTo((self?.view.snp_bottom)!).offset(-49)
            make.bottom.equalTo((self?.view)!)
        })

        for i in 0..<imageNames.count{
            let imageName = imageNames[i]
            let titleName = titleNames[i]
            let bgImageName = imageName + "_normal"
            let selectBgImageName = imageName + "_select"
            let btn = UIButton.createBtn(nil, bgImageName: bgImageName, selectBgImageName: selectBgImageName, target: self, action: #selector(clickBtn(_:)))
            bgView?.addSubview(btn)
            btn.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.top.bottom.equalTo(self!.bgView!)
                make.width.equalTo(kScreenWidth / 5.0)
                make.left.equalTo(kScreenWidth / 5.0 * (CGFloat(i)))
            })
            let label = UILabel.createLabel(titleName, font: UIFont.systemFontOfSize(9), textAlignment: .Center, textColor: UIColor.grayColor())
            btn.addSubview(label)
            label.snp_makeConstraints(closure: { (make) in
                make.left.right.equalTo(btn)
                make.height.equalTo(20)
                make.bottom.equalTo(btn.snp_bottom)
            })
            btn.tag = 300 + i
            label.tag = 400
            if i == 0{
                btn.selected = true
                label.textColor = UIColor.orangeColor()
            }
        }
    
    }
    func clickBtn(btn:UIButton){
        let lastBtn = view.viewWithTag(300 + selectedIndex)
        let lastLabel = lastBtn?.viewWithTag(400)
        if lastBtn != nil && lastLabel != nil{
            (lastBtn as! UIButton).selected = false
            (lastLabel as! UILabel).textColor = UIColor.grayColor()
        }
        let curLabel = btn.viewWithTag(400)
        if curLabel != nil{
            btn.selected = true
            (curLabel as! UILabel).textColor = UIColor.orangeColor()
        }
        selectedIndex = btn.tag - 300
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
