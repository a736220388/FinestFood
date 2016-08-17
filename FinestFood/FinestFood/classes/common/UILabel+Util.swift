//
//  UILabel+Util.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
extension UILabel{
    class func createLabel(text:String?,font:UIFont?,textAlignment:NSTextAlignment?,textColor:UIColor?)->UILabel{
        let label = UILabel()
        if let labelText = text {
            label.text = labelText
        }
        if let labelFont = font{
            label.font = labelFont
        }
        if let labelTextAlignment = textAlignment{
            label.textAlignment = labelTextAlignment
        }
        if let labelTextColor = textColor{
            label.textColor = labelTextColor
        }
        return label
    }
}
