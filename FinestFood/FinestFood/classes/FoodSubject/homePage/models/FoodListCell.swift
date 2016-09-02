//
//  FoodListCell.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FoodListCell: UITableViewCell {


    @IBOutlet weak var mainBtn: UIButton!
    @IBAction func mainBtnAction(sender: UIButton) {
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starsView: UIView!
    @IBOutlet weak var starsLabel: UILabel!
    
    var foodListModel:FSFoodListModel?{
        didSet{
            showData()
        }
    }
    func showData(){
        let url = NSURL(string: foodListModel!.cover_image_url!)
        mainBtn.userInteractionEnabled = false
        mainBtn.kf_setBackgroundImageWithURL(url, forState: .Normal, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        mainBtn.layer.cornerRadius = 5
        mainBtn.clipsToBounds = true
        let time = Int(foodListModel!.updated_at!)
        let timeUpdate = NSDate(timeIntervalSince1970: Double(time))
        var timeStr = "\(timeUpdate)"
        let tmpStr = timeStr.componentsSeparatedByString(" ")[0]
        let arr = tmpStr.componentsSeparatedByString("-")
        var month = arr[1]
        var day = arr[2]
        var week = ""
        if arr.count == 3{
            week = Util.CaculateWeekDay(tmpStr)
            if arr[1].substringToIndex(arr[1].startIndex.successor()) == "0"{
                month = arr[1].substringFromIndex(arr[1].endIndex.predecessor())
            }
            if arr[2].substringToIndex(arr[2].startIndex.successor()) == "0"{
                day = arr[2].substringFromIndex(arr[2].endIndex.predecessor())
            }
        }
        timeStr = "\(month)月\(day)日 \(week)"
        timeLabel.text = timeStr
        titleLabel.text = foodListModel!.title!
        starsLabel.text = "\(foodListModel!.likes_count!)"
        starsView.layer.cornerRadius = 10
        starsView.clipsToBounds = true
        starsView.alpha = 0.5
        starsView.backgroundColor = UIColor.blackColor()
    }
    class func createFoodListCell(tableView:UITableView,atIndexPath index:NSIndexPath,dataModel model:FSFoodListModel)->FoodListCell{
        let cellId = "foodListCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FoodListCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("FoodListCell", owner: nil, options: nil).last as? FoodListCell
        }
        cell?.selectionStyle = .None
        cell!.foodListModel = model
        return cell!
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


