//
//  CGHomeOutModel.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CGHomeOutModel: NSObject {
    var group_id:NSNumber?
    var icon_url:String?
    var id:NSNumber?
    var items_count:NSNumber?
    var name:String?
    var order:NSNumber?
    var status:NSNumber?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
class CGChannelModel:NSObject{
    var channels:[CGHomeOutModel]?
    var id: NSNumber?
    var name:String?
    var order:NSNumber?
    var status:NSNumber?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
/*
 "group_id": 1,
 "icon_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150715/rxdrgl9p5.png-pw144",
 "id": 16,
 "items_count": 18,
 "name": "DIY",
 "order": 0,
 "status": 0
 */