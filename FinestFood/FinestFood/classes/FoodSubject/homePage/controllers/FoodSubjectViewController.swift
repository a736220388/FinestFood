//
//  FoodSubjectViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FoodSubjectViewController: BaseViewController {
    
    lazy var scrollViewArray = NSMutableArray()
    lazy var titleScrollViewArray = NSMutableArray()
    private var titleScrollView:UIScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createTitleScrollView()
        createScrollViewData()
    }
    func createTitleScrollView(){
        automaticallyAdjustsScrollViewInsets = false
        titleScrollViewArray = ["精选","周末逛店","尝美食","体验课","周边游"]
        titleScrollView = UIScrollView()
        titleScrollView?.showsHorizontalScrollIndicator = false
        titleScrollView?.backgroundColor = UIColor.whiteColor()
        view.addSubview(titleScrollView!)
        titleScrollView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.left.right.equalTo(self!.view)
            make.height.equalTo(20)
            make.top.equalTo(self!.view.snp_top).offset(64)
        })
        let containerView = UIView.createUIView()
        titleScrollView!.addSubview(containerView)
        containerView.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo((self?.titleScrollView)!)
            make.height.equalTo((self?.titleScrollView)!)
        }
        var lastLabel:UILabel? = nil
        for i in 0..<titleScrollViewArray.count{
            let label = UILabel.createLabel(titleScrollViewArray[i] as? String, font: UIFont.systemFontOfSize(13), textAlignment: .Center, textColor: UIColor.blackColor())
            containerView.addSubview(label)
            label.snp_makeConstraints(closure: { (make) in
                make.top.bottom.equalTo(containerView)
                make.width.equalTo(80)
                if i == 0{
                    make.left.equalTo(containerView)
                }else{
                    make.left.equalTo((lastLabel?.snp_right)!)
                }
            })
            lastLabel = label
        }
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo((lastLabel?.snp_right)!)
        }
        
        let moreBtn = UIButton.createBtn(nil, bgImageName: "jiantou", selectBgImageName: nil, target: self, action: #selector(moreAction(_:)))
        view.addSubview(moreBtn)
        moreBtn.snp_makeConstraints {
            [weak self]
            (make) in
            make.right.equalTo(self!.view)
            make.top.equalTo((self?.view.snp_top)!).offset(64)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    func moreAction(btn:UIButton){
        UIView.beginAnimations("animate1", context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationRepeatCount(1)
        UIView.setAnimationDelegate(self)
        btn.transform = CGAffineTransformMakeRotation(3.1415926)
        UIView.commitAnimations()

    }
    func createScrollViewData(){
        let downloader = MyDownloader()
        downloader.downloadWithUrlString(FSScrollViewUrl)
        downloader.didFailWithError = {
            error in
            print(error)
        }
        downloader.didFinishWithData = {
            data in
            let jsonData = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            if jsonData.isKindOfClass(NSDictionary.self){
                let dict = jsonData as! NSDictionary
                let dataDict = dict["data"] as! NSDictionary
                let bannersArray = dataDict["banners"] as! Array<Dictionary<String,AnyObject>>
                for bannersDict in bannersArray{
                    let bannerModel = FSScrollViewDataModel()
                    bannerModel.setValuesForKeysWithDictionary(bannersDict)
                    let targetDict = bannersDict["target"] as! Dictionary<String,AnyObject>
                    let targetModel = FSTargetModel()
                    targetModel.setValuesForKeysWithDictionary(targetDict)
                    bannerModel.target = targetModel
                    self.scrollViewArray.addObject(bannerModel)
                }
            }
        }
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
