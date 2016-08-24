//
//  FoodMoreListCell.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FoodMoreListCell: UITableViewCell {

    @IBOutlet weak var mainBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starsView: UIView!
    @IBOutlet weak var starsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var model:FSFoodMoreListModel?{
        didSet{
            let url = NSURL(string: model!.cover_image_url!)
            mainBtn.kf_setBackgroundImageWithURL(url, forState: .Normal, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            mainBtn.layer.cornerRadius = 5
            mainBtn.layer.masksToBounds = true
            starsView.layer.cornerRadius = 10
            starsView.layer.masksToBounds = true
            starsView.backgroundColor = UIColor.blackColor()
            starsView.alpha = 0.5
            titleLabel.text = model!.title!
            starsLabel.text = "\(model!.likes_count!)"
        }
    }
    
    
    class func createFoodMoreListCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:FSFoodMoreListModel)->FoodMoreListCell{
        let cellId = "foodMoreListCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FoodMoreListCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("FoodMoreListCell", owner: nil, options: nil).last as? FoodMoreListCell
        }
        cell?.model = model
        return cell!
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
