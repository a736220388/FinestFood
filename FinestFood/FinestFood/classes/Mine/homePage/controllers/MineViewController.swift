//
//  MineViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MineViewController: HomeTarbarViewController {
    
    private var tbView:UITableView?
    lazy var postArray = NSMutableArray()
    lazy var listArray = NSMutableArray()
    var isLogined = false
    var selectPostBtn = false
    var userInfoModel: UserInfoModel?{
        didSet{
            tbView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBarHidden = true
        createTableView()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
        tbView?.reloadData()
    }
    func createTableView(){
        tbView = UITableView(frame: CGRectMake(0, -20, kScreenWidth, kScreenHeight - 49 + 20), style: .Plain)
        view.addSubview(tbView!)
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.scrollEnabled = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //下载用户Post信息
    func downloadUserPostData(){
        let urlString = String(format: UserInfoListUrl, limit,offset)
        let downloader = MyDownloader()
        downloader.downloadWithUrlString(urlString)
        downloader.didFailWithError = {
            error in
            print(error)
        }
        downloader.didFinishWithData = {
            [weak self]
            data in
            let jsonData = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            if jsonData.isKindOfClass(NSDictionary.self){
                let dict = jsonData as! Dictionary<String,AnyObject>
                let dataDict = dict["data"] as! Dictionary<String,AnyObject>
                let listArray = dataDict["favorite_lists"] as! Array<Dictionary<String,AnyObject>>
                for list in listArray{
                    let model = MineUserListModel()
                    model.setValuesForKeysWithDictionary(list)
                    self!.listArray.addObject(model)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self!.tbView?.reloadData()
                    print("listArray = \(self?.listArray.count)")
                })
            }
        }
    }
    func downloadUserListData(){
        let urlString = String(format: UserInfoPostUrl, limit,offset)
        let downloader = MyDownloader()
        downloader.downloadWithUrlString(urlString)
        print(urlString)
        downloader.didFailWithError = {
            error in
            print(error)
        }
        downloader.didFinishWithData = {
            [weak self]
            data in
            let jsonData = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            if jsonData.isKindOfClass(NSDictionary.self){
                let dict = jsonData as! Dictionary<String,AnyObject>
                let dataDict = dict["data"] as! Dictionary<String,AnyObject>
                let postsArray = dataDict["favorite_lists"] as! Array<Dictionary<String,AnyObject>>
                for post in postsArray{
                    let model = FSFoodListModel()
                    model.setValuesForKeysWithDictionary(post)
                    self!.postArray.addObject(model)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    print("postarray = \(self?.postArray.count)")
                    self!.tbView?.reloadData()
                })
            }
        }

    }

}
extension MineViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 && self.isLogined == true && self.selectPostBtn == false && self.postArray.count > 0{
            return self.postArray.count
        }
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cellId = "mineProfileCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? MineProfileCell
            if cell == nil{
                cell = NSBundle.mainBundle().loadNibNamed("MineProfileCell", owner: nil, options: nil).first as? MineProfileCell
            }
            cell?.selectionStyle = .None
            cell?.delegate = self
            print(self.userInfoModel)
            if (self.userInfoModel != nil) {
                cell!.configModel(self.userInfoModel!)
            }
            return cell!
        }else{
            if self.isLogined == false{
                let cellId = "mineListCellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? MineProfileCell
                if cell == nil{
                    cell = NSBundle.mainBundle().loadNibNamed("MineProfileCell", owner: nil, options: nil).last as? MineProfileCell
                }
                cell?.selectionStyle = .None
                cell?.delegate = self
                return cell!
            }else if self.isLogined == true{
                if self.selectPostBtn == true{
                    let cellId = "userListCellId"
                    var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
                    if cell == nil {
                        cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
                    }
                    if self.postArray.count > 0{
                        let model = self.listArray[indexPath.row] as! FSFoodListModel
                        let url = NSURL(string: model.cover_image_url!)
                        cell?.imageView?.kf_setImageWithURL(url)
                        cell?.textLabel?.text = model.title!
                        cell?.detailTextLabel?.text = model.short_title!
                        cell?.accessoryType = .DisclosureIndicator
                    }
                    return cell!

                }else if self.selectPostBtn == false{
                    let cellId = "userListCellId"
                    var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
                    if cell == nil {
                        cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
                    }
                    if self.listArray.count>0{
                        let model = self.listArray[indexPath.row] as! MineUserListModel
                        let url = NSURL(string: model.cover_image_url! as String)
                        cell?.imageView?.kf_setImageWithURL(url)
                        cell?.textLabel?.text = model.name! as String
                        cell?.detailTextLabel?.text = "\(model.items_count!)个"
                    }
                    return cell!
                }
            }
        }
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isLogined == true && section == 1{
            let view = UIView()
            view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
            if section == 1{
                let detailBtn = UIButton()
                detailBtn.layer.borderWidth = 1
                detailBtn.layer.borderColor = UIColor.blackColor().CGColor
                if selectPostBtn{
                    detailBtn.backgroundColor = UIColor.whiteColor()
                }else{
                    detailBtn.backgroundColor = UIColor.orangeColor()
                }
                detailBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                detailBtn.setTitle("喜欢的专题", forState: .Normal)
                view.addSubview(detailBtn)
                detailBtn.snp_makeConstraints { (make) in
                    make.bottom.left.equalTo(view)
                    make.width.equalTo(kScreenWidth/2)
                    make.top.equalTo(view).offset(5)
                }
                let commentBtn = UIButton()
                if selectPostBtn {
                    commentBtn.backgroundColor = UIColor.orangeColor()
                }else{
                    commentBtn.backgroundColor = UIColor.whiteColor()
                }
                commentBtn.layer.borderWidth = 1
                commentBtn.layer.borderColor = UIColor.blackColor().CGColor
                commentBtn.setTitle("喜欢的商品", forState: .Normal)
                commentBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                view.addSubview(commentBtn)
                commentBtn.snp_makeConstraints { (make) in
                    make.bottom.right.equalTo(view)
                    make.width.equalTo(kScreenWidth/2)
                    make.top.equalTo(view).offset(5)
                }
                detailBtn.tag = 550
                commentBtn.tag = 551
                detailBtn.addTarget(self, action: #selector(commentAction(_:)), forControlEvents: .TouchUpInside)
                commentBtn.addTarget(self, action: #selector(commentAction(_:)), forControlEvents: .TouchUpInside)
                
            }
            return view
        }
        return nil
    }
    func commentAction(btn:UIButton){
        if btn.tag == 550{
            btn.backgroundColor = UIColor.orangeColor()
            let btn1 = btn.superview?.viewWithTag(551) as! UIButton
            btn1.backgroundColor = UIColor.whiteColor()
            selectPostBtn = false
        }else if btn.tag == 551{
            btn.backgroundColor = UIColor.orangeColor()
            let btn1 = btn.superview?.viewWithTag(550) as! UIButton
            btn1.backgroundColor = UIColor.whiteColor()
            selectPostBtn = true
        }
        tbView?.reloadData()
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 250
        }else if indexPath.section == 1 && isLogined == true && selectPostBtn == false{
            return 50
        }
        return 350
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return 20
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isLogined == true && section == 1{
            return 40
        }
        return 0
    }
    
}
extension MineViewController:MineProfileCellDelegate{
    func convertBtnSelectedWith(btn: UIButton, withType type: String) {
        if type == "setting"{
            let mineSettingCtrl = MineSettingViewController()
            self.navigationController?.pushViewController(mineSettingCtrl, animated: true)
        }else if type == "login"{
            let loginCtrl = MineLoginViewController()
            self.navigationController?.pushViewController(loginCtrl, animated: true)
            loginCtrl.convertUserInfoClosure = {
                [weak self]
                model in
                self!.userInfoModel = model
                self?.isLogined = true
                self?.downloadUserListData()
                self?.downloadUserPostData()
            }
        }
    }
}


