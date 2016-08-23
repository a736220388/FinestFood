//
//  CGSubjectCell.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CGSubjectCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!

    @IBAction func moreAction(sender: AnyObject) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configModel(array:NSMutableArray){
        for subView in scrollView.subviews{
            subView.removeFromSuperview()
        }
        var lastImageView:UIImageView? = nil
        let width = 200
        let containerView = UIView()
        scrollView.addSubview(containerView)
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        for i in 0..<array.count{
            let model = array[i] as! CGCollectionsModel
            let url = NSURL(string: model.banner_image_url!)
            let imageView = UIImageView()
            imageView.layer.cornerRadius = 5
            imageView.clipsToBounds = true
            containerView.addSubview(imageView)
            imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            imageView.snp_makeConstraints(closure: {
                (make) in
                make.top.bottom.equalTo(containerView)
                if i == 0{
                    make.left.equalTo(containerView.snp_left).offset(5)
                }else{
                    make.left.equalTo(lastImageView!.snp_right).offset(5)
                }
                make.width.equalTo(width)
            })
            lastImageView = imageView
        }
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(lastImageView!)
        }
        
        scrollView.contentSize = CGSizeMake(CGFloat(array.count * width), 0)
        scrollView.showsHorizontalScrollIndicator = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
