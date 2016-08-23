//
//  CGHomeOutCell.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CGHomeOutCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configModel(array:[CGHomeOutModel],section:Int){
        let label = UILabel()
        self.contentView.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left).offset(10)
            make.top.equalTo(self.contentView.snp_top).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        if section == 1{
            label.text = "宅家"
        }else if section == 2{
            label.text = "出门"
        }
        let width = UIScreen.mainScreen().bounds.width / 4
        var colNum:CGFloat = 0
        for i in 0..<array.count{
            colNum = CGFloat(i / 4)
            let model = array[i]
            let customView = createCustomView(model.icon_url!, name: model.name!)
            self.contentView.addSubview(customView)
            customView.snp_makeConstraints(closure: { (make) in
                make.width.equalTo(width/1.5)
                make.height.equalTo(width*1.3/1.5)
                make.top.equalTo(self.contentView.snp_top).offset(35 + width*colNum)
                make.left.equalTo(self.contentView.snp_left).offset(10 + width*CGFloat(i % 4))
            })
        }
    }
    
    
    func createCustomView(imageName:String,name:String)->UIView{
        let uiView = UIView.createUIView()
        let btn = UIButton()
        uiView.addSubview(btn)
        btn.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(uiView)
            make.bottom.equalTo(uiView.snp_bottom).offset(-20)
        }
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(12)
        uiView.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.bottom.left.right.equalTo(uiView)
            make.height.equalTo(20)
        }
        btn.kf_setBackgroundImageWithURL(NSURL(string: imageName), forState: .Normal)
        label.text = name
        return uiView
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
