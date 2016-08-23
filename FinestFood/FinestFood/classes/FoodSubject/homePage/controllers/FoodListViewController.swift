//
//  FoodListViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import XWSwiftRefresh

class FoodListViewController: BaseViewController {
    
    lazy var dataArray = NSMutableArray()
    private var collView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createCollView()
    }
    func createCollView(){
        automaticallyAdjustsScrollViewInsets = false
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.itemSize = CGSizeMake((kScreenWidth-30)/2, (kScreenWidth-30)/2*1.2)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collView?.delegate = self
        collView?.dataSource = self
        collView?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        view.addSubview(collView!)
        collView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            //make.edges.equalTo((self?.view)!)
            make.top.equalTo((self?.view.snp_top)!).offset(64)
            make.right.left.equalTo((self?.view)!)
            make.bottom.equalTo((self?.view.snp_bottom)!).offset(-49)
        })
        let nib = UINib(nibName: "FSFoodListCell", bundle: nil)
        collView?.registerNib(nib, forCellWithReuseIdentifier: "foodListCellId")
        collView?.headerView = XWRefreshNormalHeader(target: self, action: #selector(firstPageAction))
        collView?.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(nextPageAction))
    }
    func firstPageAction(){
        limit = 20
        offset = 0
        downloadData()
    }
    func nextPageAction(){
        limit = 20
        offset += 20
        downloadData()
    }
    override func downloadData(){
        let url = String(format: FLFoodListUrl,gender,generation,limit,offset)
        let downloader = MyDownloader()
        downloader.downloadWithUrlString(url)
        downloader.didFailWithError = {
            error in
            print(error)
        }
        downloader.didFinishWithData = {
            [weak self]
            data in
            if self!.limit == 20 && self!.offset == 0{
                self!.dataArray.removeAllObjects()
            }
            let jsonData = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            if jsonData.isKindOfClass(NSDictionary.self){
                let dict = jsonData as! NSDictionary
                let dataDict = dict["data"] as! NSDictionary
                let itemsArray = dataDict["items"] as! Array<Dictionary<String,AnyObject>>
                for itemDict in itemsArray{
                    let itemDataDict = itemDict["data"] as! Dictionary<String,AnyObject>
                    let model = FoodListItemModel()
                    model.setValuesForKeysWithDictionary(itemDataDict)
                    self!.dataArray.addObject(model)
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    self!.collView!.reloadData()
                    self!.collView?.headerView?.endRefreshing()
                    self!.collView?.footerView?.endRefreshing()
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
extension FoodListViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellId = "foodListCellId"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as? FSFoodListCell
        let model = dataArray[indexPath.item] as! FoodListItemModel
        cell?.configModel(model)
        return cell!
    }
}
