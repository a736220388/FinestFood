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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MineViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            let cellId = "mineListCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? MineProfileCell
            if cell == nil{
                cell = NSBundle.mainBundle().loadNibNamed("MineProfileCell", owner: nil, options: nil).last as? MineProfileCell
            }
            cell?.selectionStyle = .None
            cell?.delegate = self
            return cell!
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 250
        }
        return 350
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return 20
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
            }
        }
    }
}
