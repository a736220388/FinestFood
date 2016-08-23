//
//  CategoryViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CategoryViewController: BaseViewController {

    lazy var subjectsArray = NSMutableArray()
    lazy var homeOutArray = NSMutableArray()
    private var tbView:UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createTableView()
        downloadHomeOutData()
    }
    func createTableView(){
        automaticallyAdjustsScrollViewInsets = false
        tbView = UITableView()
        tbView?.delegate = self
        tbView?.dataSource = self
        view.addSubview(tbView!)
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            //make.edges.equalTo(self!.view)
            make.left.right.equalTo((self?.view)!)
            make.top.equalTo((self?.view.snp_top)!).offset(64)
            make.bottom.equalTo((self?.view.snp_bottom)!).offset(-49)
        })
    }
    func downloadHomeOutData(){
        let downloader = MyDownloader()
        downloader.downloadWithUrlString(CGHomeOutUrl)
        downloader.didFailWithError = {
            error in
            print(error)
        }
        downloader.didFinishWithData = {
            [weak self]
            data in
            let jsonData = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            if jsonData.isKindOfClass(NSDictionary.self){
                let dict = jsonData as! NSDictionary
                let dataDict = dict["data"] as! NSDictionary
                let channelGroupsArray = dataDict["channel_groups"] as! Array<Dictionary<String,AnyObject>>
                for channelgroup in channelGroupsArray{
                    let model = CGChannelModel()
                    model.setValuesForKeysWithDictionary(channelgroup)
                    
                    var channelsArray = [CGHomeOutModel]()
                    let homeOutArray = channelgroup["channels"] as! Array<Dictionary<String,AnyObject>>
                    for channel in homeOutArray{
                        let homeOutModel = CGHomeOutModel()
                        homeOutModel.setValuesForKeysWithDictionary(channel)
                        channelsArray.append(homeOutModel)
                    }
                    model.channels = channelsArray
                    self!.homeOutArray.addObject(model)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self!.tbView?.reloadData()
                })
            }
        }
    }
    override func downloadData() {
        let downloader = MyDownloader()
        downloader.downloadWithUrlString(CGSubjectUrl)
        downloader.didFailWithError = {
            error in
            print(error)
        }
        downloader.didFinishWithData = {
            [weak self]
            data in
            let jsonData = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            if jsonData.isKindOfClass(NSDictionary.self){
                let dict = jsonData as! NSDictionary
                let dataDict = dict["data"] as! NSDictionary
                let collectionsArray = dataDict["collections"] as! Array<Dictionary<String,AnyObject>>
                for item in collectionsArray{
                    let model = CGCollectionsModel()
                    model.setValuesForKeysWithDictionary(item)
                    self!.subjectsArray.addObject(model)
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    self!.tbView?.reloadData()
                })
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
extension CategoryViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 120
        }else if indexPath.section == 1{
            return 130
        }
        return 220
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2{
            return 0
        }
        return 20
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cellId = "subjectCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CGSubjectCell
            if cell == nil{
                cell = NSBundle.mainBundle().loadNibNamed("CGSubjectCell", owner: nil, options: nil).last as? CGSubjectCell
            }
            if self.subjectsArray.count > 0{
                cell?.configModel(self.subjectsArray)
            }
            cell?.selectionStyle = .None
            return cell!
        }else if indexPath.section == 1{
            let cellId = "homeCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CGHomeOutCell
            if cell == nil{
                cell = CGHomeOutCell(style: .Subtitle, reuseIdentifier: cellId)
            }
            if homeOutArray.count != 0{
                let model = homeOutArray[0] as! CGChannelModel
                cell?.configModel(model.channels!, section: indexPath.section)
            }
            cell?.selectionStyle = .None
            return cell!
        }else if indexPath.section == 2{
            let cellId = "homeCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CGHomeOutCell
            if cell == nil{
                cell = CGHomeOutCell(style: .Subtitle, reuseIdentifier: cellId)
            }
            if homeOutArray.count != 0{
                let model = homeOutArray[1] as! CGChannelModel
                cell?.configModel(model.channels!, section: indexPath.section)
            }
            cell?.selectionStyle = .None
            return cell!
        }
        return UITableViewCell()
    }
}
