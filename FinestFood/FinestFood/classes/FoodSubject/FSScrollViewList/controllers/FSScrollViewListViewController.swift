//
//  FSScrollViewListViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FSScrollViewListViewController: BaseViewController {
    var convertListIdClosure:((NSNumber)->Void)?
    var targetId:Int?
    var tbView:UITableView?
    var dataArray:Array<FSFoodMoreListModel>?{
        didSet{
            tbView!.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.redColor()
        tbView = UITableView()
        tbView?.delegate = self
        tbView?.dataSource = self
        view.addSubview(tbView!)
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view)
        })
    }
    override func downloadData() {
        let url = String(format: FSScrollViewListlUrl, targetId!,gender,generation,limit,offset)
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
                let dataDict = jsonData["data"] as! NSDictionary
                let itemsArray = dataDict["posts"] as! Array<Dictionary<String,AnyObject>>
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
extension FSScrollViewListViewController:UITableViewDelegate,UITableViewDataSource{
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
        let foodDetailCtrl = FoodDetailViewController()
        foodDetailCtrl.id = Int(model.id!)
        self.navigationController?.pushViewController(foodDetailCtrl, animated: true)
        
    }
}

