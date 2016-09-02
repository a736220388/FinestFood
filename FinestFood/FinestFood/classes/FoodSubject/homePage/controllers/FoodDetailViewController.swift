//
//  FoodDetailViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FoodDetailViewController: BaseViewController {
    
    var id:Int?
    var foodDetailModel:FoodDetailModel?
    private var tbView:UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.blueColor()
        createTableView()
    }
    func createTableView(){
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        view.addSubview(tbView!)
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo((self?.view)!)
        })
        tbView?.delegate = self
        tbView?.dataSource = self
    }
    override func downloadData() {
        let url = String(format: FSFoodDetailUrl, id!)
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
            if jsonData.isKindOfClass(NSDictionary.self) == true{
                let dict = jsonData as! Dictionary<String,AnyObject>
                let dataDict = dict["data"] as! Dictionary<String,AnyObject>
                let model = FoodDetailModel()
                model.setValuesForKeysWithDictionary(dataDict)
                self!.foodDetailModel = model
            }
            dispatch_async(dispatch_get_main_queue(), {
                [weak self] in
                self!.tbView?.reloadData()
            })
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
extension FoodDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "foodDetailCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FoodDetailCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("FoodDetailCell", owner: nil, options: nil).last as? FoodDetailCell
        }
        if let model = foodDetailModel{
            cell?.configModel(model)
        }
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kScreenHeight - 40
    }
}
