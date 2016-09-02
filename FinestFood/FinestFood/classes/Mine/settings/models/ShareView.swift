//
//  ShareView.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class ShareView: UIView {
    @IBOutlet weak var transparentView: UIView!{
        didSet{
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
            transparentView.addGestureRecognizer(tap)
        }
    }

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var cancelBtn: UIButton!{
        didSet{
            bgView.clipsToBounds = true
            bgView.layer.cornerRadius = 5
            cancelBtn.clipsToBounds = true
            cancelBtn.layer.cornerRadius = 5
        }
    }
    @IBAction func clickBtn(sender: UIButton) {
        //tag 100~105
        self.hidden = true
    }
    @IBAction func cancelBtn(sender: UIButton) {
        self.hidden = true
    }
    
    func tapAction(tap:UIGestureRecognizer){
        self.hidden = true
    }

}
