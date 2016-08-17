
//
//  UIImageView+Util.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
extension UIImageView{
    class func createImageView(bgImageName:String?)->UIImageView{
        let imageView = UIImageView()
        if let imageViewBgImageName = bgImageName{
            imageView.image = UIImage(named: imageViewBgImageName)
        }
        return imageView
    }
}