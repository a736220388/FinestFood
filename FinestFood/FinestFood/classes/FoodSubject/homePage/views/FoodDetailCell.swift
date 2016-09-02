//
//  FoodDetailCell.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FoodDetailCell: UITableViewCell {


    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var webView: UIWebView!
    @IBAction func likeBtn(sender: UIButton) {
    }

    @IBAction func shareBtn(sender: UIButton) {
    }
    @IBAction func commentBtn(sender: UIButton) {
    }
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    
    var lastContentOffsetY:CGFloat? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configModel(model:FoodDetailModel){
        let webUrl = NSURL(string: model.url!)
        let request = NSURLRequest(URL: webUrl!)
        webView.loadRequest(request)
        webView.scrollView.delegate = self
        likeLabel.text = "\(model.likes_count!)人喜欢"
        commentLabel.text = "\(model.comments_count!)次分享"
        shareLabel.text = "\(model.shares_count!)条评论"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension FoodDetailCell:UIScrollViewDelegate{
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        if lastContentOffsetY != nil{
//            if lastContentOffsetY < webView.scrollView.contentOffset.y{
//                superView.hidden = true
//            }else{
//                superView.hidden = false
//            }
//        }
//        lastContentOffsetY = webView.scrollView.contentOffset.y
//    }
}
