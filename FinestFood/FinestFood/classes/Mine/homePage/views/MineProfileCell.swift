//
//  MineProfileCell.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol MineProfileCellDelegate:NSObjectProtocol {
    func convertBtnSelectedWith(btn:UIButton,withType type:String)
}

class MineProfileCell: UITableViewCell {
    weak var delegate:MineProfileCellDelegate?
    
    @IBOutlet weak var userPhoneLabel: UILabel!
    
    @IBAction func alertAction(sender: UIButton) {
    }
    @IBAction func steAction(sender: UIButton) {
        delegate?.convertBtnSelectedWith(sender, withType: "setting")
    }

    @IBAction func loginAction(sender: UIButton) {
        delegate?.convertBtnSelectedWith(sender, withType: "login")
    }
    
    
    @IBAction func likeProduct(sender: UIButton) {
        delegate?.convertBtnSelectedWith(sender, withType: "likeProduct")
    }
    
    @IBAction func likeSubject(sender: UIButton) {
        delegate?.convertBtnSelectedWith(sender, withType: "likeSubject")
    }
    
    func configModel(model:UserInfoModel){
        userPhoneLabel.text = model.nickname!
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
