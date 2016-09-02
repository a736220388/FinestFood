//
//  FSSearchViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FSSearchViewController: BaseViewController {
    
    var searchBar:UISearchBar?
    var tbView:UITableView?
    lazy var searchDataArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar = UISearchBar(frame: CGRectMake(0,0,kScreenWidth-80,40))
        searchBar?.placeholder = "搜索商品,专题"
        searchBar?.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar!)
        let backBtn = UIButton(frame: CGRectMake(0,0,40,40))
        backBtn.setTitle("返回", forState: .Normal)
        backBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        backBtn.addTarget(self, action: #selector(backAction), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        createTableView()
    }
    func backAction(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func createTableView(){
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        view.addSubview(tbView!)
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view)
        })
        tbView?.delegate = self
        tbView?.dataSource = self
    }
    override func downloadData() {
        let url = FSSearchWordUrl
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
                let dict = jsonData as! NSDictionary
                let dataDict = dict["data"] as! Dictionary<String,AnyObject>
                let hotwordsArray = dataDict["hot_words"] as! NSMutableArray
                self!.searchDataArray = hotwordsArray
            }
            dispatch_async(dispatch_get_main_queue(), {
                self!.tbView?.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension FSSearchViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "searchCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if cell == nil{
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
        }
        
        let label = UILabel.createLabel("大家也在搜", font: UIFont.systemFontOfSize(17), textAlignment: .Left, textColor: UIColor.grayColor())
        cell?.contentView.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.left.equalTo((cell?.contentView)!).offset(20)
            make.right.equalTo((cell?.contentView)!).offset(-20)
            make.top.equalTo((cell?.contentView.snp_top)!).offset(20)
            make.height.equalTo(30)
        }
        if searchDataArray.count > 0{
            let btnW:CGFloat = 60
            let btnH:CGFloat = 30
            let spaceX:CGFloat = 20
            let spaceY:CGFloat = 20
            let num = Int((kScreenWidth - spaceX) / (spaceX + btnW))
            for i in 0..<searchDataArray.count{
                let colNum = i / num
                let rowNum = i % num
                let wordBtn = UIButton.createBtn(searchDataArray[i] as? String, bgImageName: nil, selectBgImageName: nil, target: self, action: #selector(searchAction(_:)))
                wordBtn.titleLabel?.textAlignment = .Center
                wordBtn.tag = 350 + i
                cell?.contentView.addSubview(wordBtn)
                wordBtn.snp_makeConstraints(closure: { (make) in
                    make.top.equalTo(label.snp_bottom).offset(spaceY + (btnH+spaceY)*CGFloat(colNum))
                    make.left.equalTo((cell?.contentView)!).offset(spaceX + (spaceX+btnW)*CGFloat(rowNum))
                    make.width.equalTo(btnW)
                    make.height.equalTo(btnH)
                })
            }
        }
        return cell!
    }
    func searchAction(btn:UIButton){
        let index = btn.tag - 350
        let title = searchDataArray[index] as! String
        let str = title.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet())
        let itemUrlString = String(format: FSSearchItemResultUrl, str!,limit,offset)
        let postUrlString = String(format: FSSearchPostResultUrl, str!,limit,offset)
        let resultCtrl = FSSearchResultViewController()
        resultCtrl.itemUrlString = itemUrlString
        resultCtrl.postUrlString = postUrlString
        resultCtrl.searchBarKey = title
        self.navigationController?.pushViewController(resultCtrl, animated: true)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let btnW:CGFloat = 60
        let btnH:CGFloat = 30
        let spaceX:CGFloat = 20
        let spaceY:CGFloat = 20
        let num = Int((kScreenWidth - spaceX) / (spaceX + btnW))
        let colNum = CGFloat(searchDataArray.count / num)*(spaceY+btnH) + (spaceY+btnH) + spaceY
        return colNum
    }
    
}
//searchBar的代理方法
extension FSSearchViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        let title = searchBar.text
        let str = title!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet())
        let itemUrlString = String(format: FSSearchItemResultUrl, str!,limit,offset)
        let postUrlString = String(format: FSSearchPostResultUrl, str!,limit,offset)
        let resultCtrl = FSSearchResultViewController()
        resultCtrl.itemUrlString = itemUrlString
        resultCtrl.postUrlString = postUrlString
        resultCtrl.searchBarKey = title!
        self.navigationController?.pushViewController(resultCtrl, animated: true)
    }

}
