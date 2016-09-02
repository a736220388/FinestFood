//
//  FSSearchResultViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FSSearchResultViewController: FSSearchViewController {
    
    var itemUrlString = ""
    var postUrlString = ""
    lazy var foodItemArray = NSMutableArray()
    lazy var foodPostArray = NSMutableArray()
    var convertListIdClosure:((NSNumber)->Void)?
    var isItem:Bool = true{
        didSet{
            if isItem{
                for subView in self.view.subviews{
                    if subView.tag == 700{
                        subView.removeFromSuperview()
                    }
                }
                createCollView()
            }else{
                for subView in self.view.subviews{
                    if subView.tag == 701{
                        subView.removeFromSuperview()
                    }
                }
                createTableView()
            }
        }
    }

    private var collView:UICollectionView?
    private var titleView:UIView?
    var searchBarKey = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        automaticallyAdjustsScrollViewInsets = false
        createTitleBtn()
        downloadPostData()
        isItem = true
        searchBar?.text = searchBarKey
    }
    
    func createTitleBtn(){
        titleView = UIView()
        titleView!.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        view.addSubview(titleView!)
        titleView!.snp_makeConstraints {
            [weak self]
            (make) in
            make.left.right.equalTo(self!.view)
            make.top.equalTo((self?.view)!).offset(64)
            make.height.equalTo(30)
        }
        let postBtn = UIButton()
        postBtn.layer.borderWidth = 1
        postBtn.layer.borderColor = UIColor.blackColor().CGColor
        if isItem{
            postBtn.backgroundColor = UIColor.whiteColor()
        }else{
            postBtn.backgroundColor = UIColor.orangeColor()
        }
        postBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        postBtn.setTitle("攻略", forState: .Normal)
        titleView!.addSubview(postBtn)
        postBtn.snp_makeConstraints { (make) in
            make.bottom.left.top.equalTo(titleView!)
            make.width.equalTo(kScreenWidth/2)
        }
        let listBtn = UIButton()
        if isItem {
            listBtn.backgroundColor = UIColor.orangeColor()
        }else{
            listBtn.backgroundColor = UIColor.whiteColor()
        }
        listBtn.layer.borderWidth = 1
        listBtn.layer.borderColor = UIColor.blackColor().CGColor
        listBtn.setTitle("商品", forState: .Normal)
        listBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        titleView!.addSubview(listBtn)
        listBtn.snp_makeConstraints { (make) in
            make.bottom.right.top.equalTo(titleView!)
            make.width.equalTo(kScreenWidth/2)
        }
        postBtn.tag = 650
        listBtn.tag = 651
        postBtn.addTarget(self, action: #selector(clickAction(_:)), forControlEvents: .TouchUpInside)
        listBtn.addTarget(self, action: #selector(clickAction(_:)), forControlEvents: .TouchUpInside)
    }
    func clickAction(btn:UIButton){
        if btn.tag == 650{
            btn.backgroundColor = UIColor.orangeColor()
            let btn1 = btn.superview?.viewWithTag(651) as! UIButton
            btn1.backgroundColor = UIColor.whiteColor()
            isItem = false
        }else if btn.tag == 651{
            btn.backgroundColor = UIColor.orangeColor()
            let btn1 = btn.superview?.viewWithTag(650) as! UIButton
            btn1.backgroundColor = UIColor.whiteColor()
            isItem = true
        }
    }
    
    override func createTableView(){
        tbView = UITableView(frame: CGRectMake(0, 64 + 30, kScreenWidth, kScreenHeight-64-30), style: .Plain)
        tbView?.tag = 700
        tbView?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        view.addSubview(tbView!)
        tbView?.delegate = self
        tbView?.dataSource = self
    }
    func createCollView(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.itemSize = CGSizeMake((kScreenWidth-30)/2, (kScreenWidth-30)/2*1.2)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collView?.tag = 701
        collView?.delegate = self
        collView?.dataSource = self
        collView?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        view.addSubview(collView!)
        collView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.top.equalTo((self?.view.snp_top)!).offset(64 + 30)
            make.right.left.equalTo((self?.view)!)
            make.bottom.equalTo((self?.view.snp_bottom)!).offset(0)
            })
        let nib = UINib(nibName: "FSFoodListCell", bundle: nil)
        collView?.registerNib(nib, forCellWithReuseIdentifier: "foodListCellId")
    }
    
    override func downloadData() {
        if itemUrlString == ""{
            return
        }
        let downloader = MyDownloader()
        downloader.downloadWithUrlString(itemUrlString)
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
                let itemsArray = dataDict["items"] as! Array<Dictionary<String,AnyObject>>
                for itemDict in itemsArray{
                    let model = FoodListItemModel()
                    model.setValuesForKeysWithDictionary(itemDict)
                    self!.foodItemArray.addObject(model)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self!.collView?.reloadData()
                })
            }
        }
    }
    func downloadPostData(){
        if postUrlString == ""{
            return
        }
        let downloader = MyDownloader()
        downloader.downloadWithUrlString(postUrlString)
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
                let itemsArray = dataDict["posts"] as! Array<Dictionary<String,AnyObject>>
                for itemDict in itemsArray{
                    let model = FSFoodMoreListModel()
                    model.setValuesForKeysWithDictionary(itemDict)
                    self!.foodPostArray.addObject(model)
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
extension FSSearchResultViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if foodPostArray.count == 0{
            return 0
        }
        return foodPostArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let model = foodPostArray[indexPath.row] as! FSFoodMoreListModel
        let cell = FoodMoreListCell.createFoodMoreListCellFor(tableView, atIndexPath: indexPath, withModel: model)
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = foodPostArray[indexPath.row] as! FSFoodMoreListModel
        let foodDetailCtrl = FoodDetailViewController()
        foodDetailCtrl.id = Int(model.id!)
        self.navigationController?.pushViewController(foodDetailCtrl, animated: true)
    }
}

extension FSSearchResultViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodItemArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellId = "foodListCellId"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as? FSFoodListCell
        let model = foodItemArray[indexPath.item] as! FoodListItemModel
        cell?.configModel(model)
        return cell!
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let model = foodItemArray[indexPath.item] as! FoodListItemModel
        let detailCtrl = FoodListDetailViewController()
        detailCtrl.itemId = Int(model.id!)
        detailCtrl.isSearchResult = true
        detailCtrl.detailModel = model
        navigationController?.pushViewController(detailCtrl, animated: true)
    }

}
