//
//  CGListViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CGListViewController: BaseViewController {
    var typeValue:Int?
    var dataArray:Array<FSFoodMoreListModel>?
    private var tbView:UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createTableView()
    }
    func createTableView(){
        tbView = UITableView()
        view.addSubview(tbView!)
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.left.right.bottom.top.equalTo(self!.view)
        })
        tbView?.delegate = self
        tbView?.dataSource = self
    }
    override func downloadData() {
        let downloader = MyDownloader()
        let url = String(format: FSFoodMoreListUrl,typeValue!,limit,offset)
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
                self!.dataArray = dataArr
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
extension CGListViewController:UITableViewDelegate,UITableViewDataSource{
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
        let detailCtrl = FoodDetailViewController()
        detailCtrl.id = Int(model.id!)
        self.navigationController?.pushViewController(detailCtrl, animated: true)
    }
}
