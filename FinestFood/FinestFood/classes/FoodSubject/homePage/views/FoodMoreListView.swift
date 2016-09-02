//
//  FoodMoreListView.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FoodMoreListView: UIView {
    var convertListIdClosure:((NSNumber)->Void)?
    private var tbView:UITableView?
    var dataArray:Array<FSFoodMoreListModel>?{
        didSet{
            tbView!.reloadData()
        }
    }
    init(){
        super.init(frame: CGRectZero)
        tbView = UITableView()
        tbView?.delegate = self
        tbView?.dataSource = self
        addSubview(tbView!)
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downloadFoodMoreListData(typeValue:Int,limit:Int,offset:Int){
        let downloader = MyDownloader()
        let url = String(format: FSFoodMoreListUrl,typeValue,limit,offset)
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
                let dataDict = jsonData["data"] as! NSDictionary
                let itemsArray = dataDict["items"] as! Array<Dictionary<String,AnyObject>>
                var dataArr = Array<FSFoodMoreListModel>()
                for dict in itemsArray{
                    let model = FSFoodMoreListModel()
                    model.setValuesForKeysWithDictionary(dict)
                    dataArr.append(model)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self!.dataArray = dataArr
                })
            }
        }
    }
}
extension FoodMoreListView:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray == nil {
            return 0
        }
        return (dataArray?.count)!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let model = dataArray![indexPath.row]
        let cell = FoodMoreListCell.createFoodMoreListCellFor(tableView, atIndexPath: indexPath, withModel: model)
        cell.selectionStyle = .None
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = dataArray![indexPath.row]
        convertListIdClosure!(model.id!)
    }
}
