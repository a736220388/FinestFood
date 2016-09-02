//
//  MineSettingViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MineSettingViewController: BaseViewController {
    
    var dataArray:NSMutableArray?
    private var tbView:UITableView?
    
    var role = "职场新人"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBarHidden = false
        createDataArray()
        createTableView()
        title = "更多"
    }
    
    func createDataArray(){
        let titles = ["邀请好友使用食不厌精","给我们评分吧","意见反馈","我的身份","接收消息提醒","清除缓存","关于食不厌精"]
        let imageNames = ["setInvi","setStars","setAdvice","setMe","setAlart","setClear","setAbout"]
        let detailBtns = [false,false,true,true,false,false,true]
        dataArray = NSMutableArray()
        for i in 0..<7{
            let array = [titles[i],imageNames[i],detailBtns[i]]
            dataArray?.addObject(array)
        }
    }
    func createTableView(){
        tbView = UITableView()
        view.addSubview(tbView!)
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view)
        })
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
    }
}
extension MineSettingViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }else if section == 1{
            return 3
        }else if section == 2{
            return 1
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "mineSettingCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if cell == nil{
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellId)
        }
        var modelArray:Array<AnyObject> = Array<AnyObject>()
        if indexPath.section == 0{
            modelArray = (dataArray![indexPath.row] as? Array<AnyObject>)!
        }else if indexPath.section == 1{
            modelArray = (dataArray![indexPath.row + 3] as? Array<AnyObject>)!
        }else if indexPath.section == 2{
            modelArray = (dataArray![indexPath.row + 6] as? Array<AnyObject>)!
        }
        cell?.selectionStyle = .None
        cell?.textLabel?.text = modelArray[0] as? String
        cell?.imageView?.image = UIImage()
        let imgView = UIImageView()
        imgView.image = UIImage(named: modelArray[1] as! String)
        cell?.contentView.addSubview(imgView)
        imgView.snp_makeConstraints {
            [weak cell]
            (make) in
            make.top.equalTo((cell?.contentView.snp_top)!).offset(10)
            make.left.equalTo((cell?.contentView.snp_left)!).offset(5)
            make.bottom.equalTo((cell?.contentView.snp_bottom)!).offset(-10)
            make.width.equalTo(20)
        }
        if (modelArray[2] as! Bool) == true{
            cell?.accessoryType = .DisclosureIndicator
        }
        if indexPath.section == 1{
            if indexPath.row == 0{
                var genderStr = ""
                if self.gender == 0{
                    genderStr = "男孩"
                }else if self.gender == 1{
                    genderStr = "女孩"
                }
                cell?.detailTextLabel?.text = "\(genderStr) \(self.role)"
            }else if indexPath.row == 1{
                let switchView = UISwitch()
                cell?.contentView.addSubview(switchView)
                switchView.snp_makeConstraints(closure: {
                    [weak cell]
                    (make) in
                    make.top.equalTo((cell?.contentView.snp_top)!).offset(5)
                    make.right.equalTo((cell?.contentView.snp_right)!).offset(-5)
                    make.bottom.equalTo((cell?.contentView.snp_bottom)!).offset(-5)
                    make.width.equalTo(60)
                })
            }
            
        }
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
            if indexPath.row == 0{
                let shareView = NSBundle.mainBundle().loadNibNamed("ShareView", owner: nil, options: nil).last as? UIView
                self.view.addSubview(shareView!)
                shareView?.snp_makeConstraints(closure: {
                    [weak self]
                    (make) in
                    make.left.right.bottom.equalTo(self!.view)
                    make.top.equalTo(self!.view).offset(64)
                })
            }else if indexPath.row == 2{
                let feedBackCtrl = FeedBackViewController()
                self.navigationController?.pushViewController(feedBackCtrl, animated: true)
            }
            
        }else if indexPath.section == 1{
            if indexPath.row == 0{
                let roleView = RoleView()
                self.view.addSubview(roleView)
                roleView.snp_makeConstraints(closure: {
                    [weak self]
                    (make) in
                    make.edges.equalTo(self!.view)
                })
                roleView.roleClosure = {
                    [weak self]
                    gender,role in
                    self!.gender = gender
                    self?.role = role
                    self!.tbView?.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                }
            }
        }
    }
}
