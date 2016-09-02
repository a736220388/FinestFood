//
//  FLFoodCommentCell.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FLFoodCommentCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var repliedUserName: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configModel(model: FLDetailModel){
        let repliedUserModel = model.user
        let url = NSURL(string: (repliedUserModel?.avatar_url)!)
        userImage.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        userImage.layer.cornerRadius = 25
        userImage.clipsToBounds = true
        userName.text = model.user?.nickname!
        repliedUserName.text = model.required_user?.nickname!
        content.text = model.content!
        
        let time = Int(model.created_at!)
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
        timeStr = "\(month)-\(day) \(week)"
        timeLabel.text = timeStr
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
