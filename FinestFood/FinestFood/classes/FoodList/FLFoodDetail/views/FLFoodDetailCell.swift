//
//  FLFoodDetailCell.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FLFoodDetailCell: UITableViewCell {
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configModel(model:FoodListItemModel){
        let containerView = UIView.createUIView()
        scrollView.addSubview(containerView)
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        var lastImage:UIImageView? = nil
        if model.image_urls?.count > 0{
            for i in 0..<(model.image_urls!).count{
                let imageUrlString = (model.image_urls!)[i]
                let imageView = UIImageView.createImageView(nil)
                imageView.kf_setImageWithURL(NSURL(string: imageUrlString as! String), placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                containerView.addSubview(imageView)
                imageView.snp_makeConstraints(closure: { (make) in
                    if i == 0{
                        make.left.top.bottom.equalTo(containerView)
                        make.width.equalTo(kScreenWidth)
                    }else{
                        make.left.equalTo((lastImage?.snp_right)!)
                        make.top.bottom.equalTo(containerView)
                        make.width.equalTo(kScreenWidth)
                    }
                })
                lastImage = imageView
            }
            containerView.snp_makeConstraints { (make) in
                make.right.equalTo(lastImage!)
            }
            if (model.image_urls!).count > 1{
                pageCtrl.numberOfPages = (model.image_urls!).count
            }else{
                pageCtrl.hidden = true
            }
        }
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        
        titleLabel.text = model.name!
        titleLabel.numberOfLines = 0
        priceLabel.text = "¥\(model.price!)"
        descLabel.text = "        " + model.desc!
        descLabel.numberOfLines = 0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FLFoodDetailCell:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        pageCtrl.currentPage = index
    }
}
