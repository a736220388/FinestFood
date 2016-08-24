//
//  FoodDetailWebCell.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FoodDetailWebCell: UITableViewCell {
    
    var webView = UIWebView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func configModel(model:FoodDetailModel){
        contentView.addSubview(webView)
        webView.backgroundColor = UIColor.redColor()
        contentView.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        let webUrl = NSURL(string: model.url!)
        let request = NSURLRequest(URL: webUrl!)
        webView.loadRequest(request)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
