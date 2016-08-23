//
//  FSFoodListCell.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/19.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FSFoodListCell: UICollectionViewCell {

    @IBOutlet weak var btn: UIButton!
    
    @IBAction func clickBtn(sender: UIButton) {
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    
    func configModel(model:FoodListItemModel){
        btn.backgroundColor = UIColor.whiteColor()
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        let url = NSURL(string: model.cover_image_url!)
        imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        descLabel.text = model.name!
        priceLabel.text = "¥\(model.price!)"
        starsLabel.text = "\(model.favorites_count!)"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
