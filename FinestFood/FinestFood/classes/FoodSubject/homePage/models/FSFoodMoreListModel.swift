//
//  FSFoodMoreListModel.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FSFoodMoreListModel: NSObject {
    var content_url:String?
    var cover_image_url:String?
    var created_at:NSNumber?
    var id:NSNumber?
    var labels:NSArray?
    var liked:Bool?
    var likes_count:NSNumber?
    var published_at:NSNumber?
    var share_msg:String?
    var short_title:String?
    var status:NSNumber?
    var title:String?
    var type:String?
    var updated_at:NSNumber?
    var url:String?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
/*
 "content_url": "http://guozhoumo.liwushuo.com/posts/1268/content",
 "cover_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150807/3sry6kwiz.jpg-w720",
 "created_at": 1439364978,
 "id": 1268,
 "labels": [],
 "liked": false,
 "likes_count": 2654,
 "published_at": 1439364978,
 "share_msg": "暑假是聚会的好时机，约上10来个老同学出来，去哪儿合适呢？天气又热，大家都不想到户外活动，去KTV的话，总有几个羞涩的。要想让大家都能玩儿的high，不如一起去桌游吧！通过桌游，锻炼记忆力思考力，让大家都能充分的沟通，增进感情，再也不会有人拿着手机在一旁寂寞咯~！",
 "short_title": "桌游吧",
 "status": 0,
 "title": "谁都别闲着，桌游吧走起",
 "type": "post",
 "updated_at": 1438938332,
 "url": "http://guozhoumo.liwushuo.com/posts/1268"
 */