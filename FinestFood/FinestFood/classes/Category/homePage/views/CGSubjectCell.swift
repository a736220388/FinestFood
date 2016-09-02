//
//  CGSubjectCell.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
protocol CGSubjectCellDelegate:NSObjectProtocol {
    func convertValueWithModel(model:CGCollectionsModel)
}

class CGSubjectCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!

    @IBAction func moreAction(sender: AnyObject) {
    }
    
    var modelArray:NSMutableArray?
    var delegate:CGSubjectCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configModel(array:NSMutableArray){
        modelArray = array
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
            let g = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
            imageView.addGestureRecognizer(g)
            imageView.tag = 350+i
            imageView.userInteractionEnabled = true
            containerView.userInteractionEnabled = true
        }
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(lastImageView!)
        }
        
        scrollView.contentSize = CGSizeMake(CGFloat(array.count * width), 0)
        scrollView.showsHorizontalScrollIndicator = false
    }
    func tapAction(g:UIGestureRecognizer){
        let index = (g.view?.tag)! - 350
        let model = modelArray![index] as! CGCollectionsModel
        delegate?.convertValueWithModel(model)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
