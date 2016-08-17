//
//  FSScrollViewDataModel.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FSScrollViewDataModel: NSObject {
    var channel:String?
    var id:NSNumber?
    var image_url:String?
    var order:NSNumber?
    var status:NSNumber?
    var target:FSTargetModel?
    var target_id:NSNumber?
    var target_url:String?
    var type:String?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
class FSTargetModel: NSObject{
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
 {
 "code": 200,
 "data": {
 "banners": [
 {
 "channel": "all",
 "id": 6,
 "image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150808/c1x0r4brx.jpg-w720",
 "order": 4,
 "status": 0,
 
 "target_id": 3,
 "target_url": "",
 "type": "collection"
 },
 {
 "channel": "all",
 "id": 5,
 "image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150808/x740r99f3.jpg-w720",
 "order": 3,
 "status": 0,
 "target": {
 "banner_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150808/n8usq828z.jpg-w300",
 "cover_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150808/7e9khx92a.jpg-w720",
 "created_at": 1439014662,
 "id": 4,
 "posts_count": 4,
 "status": 0,
 "subtitle": null,
 "title": "体验课",
 "updated_at": 1439014662
 },
 "target_id": 4,
 "target_url": "",
 "type": "collection"
 },
 {
 "channel": "all",
 "id": 3,
 "image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150717/9p2cab9fg.jpg-w720",
 "order": 0,
 "status": 0,
 "target": {
 "banner_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150715/w12wst73l.jpg-w300",
 "cover_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150715/xwgw0glpo.jpg-w720",
 "created_at": 1436951623,
 "id": 2,
 "posts_count": 3,
 "status": 0,
 "subtitle": "需要好电影配",
 "title": "周末宅家",
 "updated_at": 1436951623
 },
 "target_id": 2,
 "target_url": "",
 "type": "collection"
 }
 ]
 },
 "message": "OK"
 }
 */