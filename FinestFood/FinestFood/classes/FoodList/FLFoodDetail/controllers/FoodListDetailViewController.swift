//
//  FoodListDetailViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FoodListDetailViewController: BaseViewController {
    
    var itemId:Int?
    lazy var dataArray = NSMutableArray()
    private var tbView:UITableView?
    var detailModel:FoodListItemModel?
    var isSearchResult = false
    var selectedComment = true{
        didSet{
            tbView?.reloadSections(NSIndexSet(index:1), withRowAnimation: .Automatic)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createTableView()
    }
    func createTableView(){
        automaticallyAdjustsScrollViewInsets = false
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        view.addSubview(tbView!)
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, -100, 0))
        })
        tbView?.delegate = self
        tbView?.dataSource = self
    }
    override func downloadData() {
        var url = ""
        if isSearchResult {
            selectedComment = false
            url = String(format: FLFoodSearchDetailUrl,itemId!)
            let downloader = MyDownloader()
            downloader.downloadWithUrlString(url)
            downloader.didFailWithError = {
                error in
                print(error)
            }
            downloader.didFinishWithData = {
                [weak self]
                data in
                let jsonData = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
                if jsonData.isKindOfClass(NSDictionary.self){
                    let dataDict = jsonData["data"] as! Dictionary<String,AnyObject>
                    self!.detailModel?.image_urls = dataDict["image_urls"] as? NSArray
                    self!.detailModel?.desc = dataDict["description"] as? String
                    self!.detailModel?.name = dataDict["name"] as? String
                    self!.detailModel?.price = dataDict["price"] as? String
                    self!.detailModel?.url = dataDict["url"] as? String
                    dispatch_async(dispatch_get_main_queue(), {
                        self!.tbView?.reloadData()
                    })
                }
            }

        }
        url = String(format: FLFoodDetailUrl,itemId!,limit,offset)
        let downloader = MyDownloader()
        downloader.downloadWithUrlString(url)
        downloader.didFailWithError = {
            error in
            print(error)
        }
        downloader.didFinishWithData = {
            [weak self]
            data in
            let jsonData = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            if jsonData.isKindOfClass(NSDictionary.self){
                let dataDict = jsonData["data"] as! Dictionary<String,AnyObject>
                let commentsArray = dataDict["comments"] as! Array<Dictionary<String,AnyObject>>
                for comment in commentsArray{
                    let model = FLDetailModel()
                    
                    if let value = comment["replied_comment"]{
                        let repliedCommentDict = value as! Dictionary<String,AnyObject>
                        let repliedCommentModel = FLRepliedCommentModel()
                        repliedCommentModel.setValuesForKeysWithDictionary(repliedCommentDict)
                        model.required_comment = repliedCommentModel
                    }
                    if let value = comment["replied_user"]{
                        let repliedUserDict = value as! Dictionary<String,AnyObject>
                        let repliedUserModel = FLRepliedUserModel()
                        repliedUserModel.setValuesForKeysWithDictionary(repliedUserDict)
                        model.required_user = repliedUserModel
                    }
                    if let value = comment["user"]{
                        let userDict = value as! Dictionary<String,AnyObject>
                        let userModel = FLUserModel()
                        userModel.setValuesForKeysWithDictionary(userDict)
                        model.user = userModel
                    }
                    model.content = comment["content"] as? String
                    model.created_at = comment["created_at"] as? NSNumber
                    model.id = comment["id"] as? NSNumber
                    model.item_id = comment["item_id"] as? NSNumber
                    model.reply_to_id = comment["reply_to_id"] as? NSNumber
                    model.show = comment["show"] as? Bool
                    model.status = comment["status"] as? NSNumber
                    
                    self!.dataArray.addObject(model)
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
    


}
extension FoodListDetailViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            if selectedComment == true{
                return dataArray.count
            }else{
                return 1
            }
            
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cellId = "foodDetailCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FLFoodDetailCell
            if cell == nil{
                cell = NSBundle.mainBundle().loadNibNamed("FLFoodDetailCell", owner: nil, options: nil).last as? FLFoodDetailCell
            }
            if let model = detailModel{
                cell?.configModel(model)
            }
            cell?.selectionStyle = .None
            return cell!
        }else if indexPath.section == 1{
            if selectedComment == true{
                let cellId = "foodCommentCellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FLFoodCommentCell
                if cell == nil{
                    cell = NSBundle.mainBundle().loadNibNamed("FLFoodCommentCell", owner: nil, options: nil).last as? FLFoodCommentCell
                }
                let model = dataArray[indexPath.row] as! FLDetailModel
                cell?.configModel(model)
                cell?.selectionStyle = .None
                return cell!

            }else{
                let cellId = "detailCellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
                if cell == nil{
                    cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
                }
                let webView = UIWebView()
                cell?.contentView.addSubview(webView)
                webView.snp_makeConstraints(closure: { (make) in
                    make.edges.equalTo((cell?.contentView)!)
                })
                let request = NSURLRequest(URL: NSURL(string: (detailModel?.url)!)!)
                webView.loadRequest(request)
                return cell!
            }
        }
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            let colNum = ((detailModel?.desc?.characters.count)! + 8) / 24
            return CGFloat(colNum*25 + 300 + 50 + 20 + 10)
        }else if indexPath.section == 1{
            if selectedComment{
                return 70
            }else{
                return kScreenHeight
            }
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1{
            return 100
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 40
        }
        return 0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        if section == 1{
            let detailBtn = UIButton()
            detailBtn.layer.borderWidth = 1
            detailBtn.layer.borderColor = UIColor.blackColor().CGColor
            if selectedComment{
                detailBtn.backgroundColor = UIColor.whiteColor()
            }else{
                detailBtn.backgroundColor = UIColor.orangeColor()
            }
            detailBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            detailBtn.setTitle("详情", forState: .Normal)
            view.addSubview(detailBtn)
            detailBtn.snp_makeConstraints { (make) in
                make.bottom.left.equalTo(view)
                make.width.equalTo(kScreenWidth/2)
                make.top.equalTo(view).offset(5)
            }
            let commentBtn = UIButton()
            if selectedComment {
                commentBtn.backgroundColor = UIColor.orangeColor()
            }else{
                commentBtn.backgroundColor = UIColor.whiteColor()
            }
            commentBtn.layer.borderWidth = 1
            commentBtn.layer.borderColor = UIColor.blackColor().CGColor
            commentBtn.setTitle("评论(\(dataArray.count))", forState: .Normal)
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
    func commentAction(btn:UIButton){
        if btn.tag == 550{
            btn.backgroundColor = UIColor.orangeColor()
            let btn1 = btn.superview?.viewWithTag(551) as! UIButton
            btn1.backgroundColor = UIColor.whiteColor()
            selectedComment = false
        }else if btn.tag == 551{
            btn.backgroundColor = UIColor.orangeColor()
            let btn1 = btn.superview?.viewWithTag(550) as! UIButton
            btn1.backgroundColor = UIColor.whiteColor()
            selectedComment = true
        }
    }
}

