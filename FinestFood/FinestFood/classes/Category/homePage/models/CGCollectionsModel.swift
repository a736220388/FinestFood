//
//  CGCollectionsModel.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CGCollectionsModel: NSObject {
    var banner_image_url:String?
    var cover_image_url:String?
    var created_at:NSNumber?
    var id:NSNumber?
    var posts_count:NSNumber?
    var status:NSNumber?
    var subtitle:String?
    var title:String?
    var updated_at:NSNumber?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
/*
 "banner_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150808/n8usq828z.jpg-w300",
 "cover_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150808/7e9khx92a.jpg-w720",
 "created_at": 1439014662,
 "id": 4,
 "posts_count": 4,
 "status": 0,
 "subtitle": null,
 "title": "体验课",
 "updated_at": 1439014662
 */