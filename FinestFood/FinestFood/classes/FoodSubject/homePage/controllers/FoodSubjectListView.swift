//
//  FoodSubjectListView.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FoodSubjectListView: UIView {
    var tbView:UITableView?
    var convertIdClosure:((NSNumber,String)->Void)?
    var scrollViewArray:NSMutableArray?{
        didSet{
            self.tbView?.reloadData()
        }
    }
    var foodListArray:NSMutableArray?{
        didSet{
            self.tbView?.reloadData()
        }
    }
    
    init(){
        super.init(frame: CGRectZero)
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        self.addSubview(tbView!)
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.separatorStyle = .None
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension FoodSubjectListView:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.foodListArray == nil{
            return 1
        }
        return 1 + (self.foodListArray?.count)!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 1
        if section == 0{
            rowNum = 1
        }
        return rowNum
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var heightRorRow:CGFloat = 200
        if indexPath.section == 0{
            heightRorRow = 150
        }
        return heightRorRow
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if self.foodListArray == nil{
            return UITableViewCell()
        }
        var cell = UITableViewCell()
        if indexPath.section == 0{
            if scrollViewArray?.count > 0{
                cell = FSAdCell.createAdCell(tableView, atIndexPath: indexPath, withDataArray: scrollViewArray!,closure:self.convertIdClosure)
            }
        }else{
            if scrollViewArray?.count > 0{
                let model = foodListArray![indexPath.section - 1] as! FSFoodListModel
                cell = FoodListCell.createFoodListCell(tableView, atIndexPath: indexPath, dataModel: model)
            }
        }
        
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
            
        }else{
            let model = foodListArray![indexPath.section - 1] as! FSFoodListModel
            convertIdClosure!(model.id!,"CELL")
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else if section == 1{
            return 20
        }
        return 10
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        return view
    }
    
}
