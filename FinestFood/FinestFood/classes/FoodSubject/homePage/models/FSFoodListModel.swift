//
//  FSFoodListModel.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FSFoodListModel: NSObject {
    var content_url:String?
    var cover_image_url:String?
    var created_at:NSNumber?
    var editor_id:NSNumber?
    var id:NSNumber?
    var labels:NSArray?
    var liked:Bool?
    var likes_count:NSNumber?
    var published_at:NSNumber?
    var share_msg:String?
    var short_title:String?
    var status:NSNumber?
    var template:String?
    var title:String?
    var type:String?
    var updated_at:NSNumber?
    var url:String?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
/*
 "content_url": "http://guozhoumo.liwushuo.com/posts/2083/content",
 "cover_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150930/6n7mqcf5i.jpg-w720",
 "created_at": 1451520000,
 "editor_id": null,
 "id": 2083,
 "labels": [],
 "liked": false,
 "likes_count": 1575,
 "published_at": 1451520000,
 "share_msg": "爱猫咪的咖啡店主们，会把猫咪放在店里方便照看，自然而然也就吸引了很多猫猫控前来，这些萌萌的喵星人性格温顺，它们每天的工作就是吃饭、睡觉、卖萌&hellip;&hellip;咖啡时光有喵星人陪伴，真是一件有爱的事情。今天又要去对那些人类卖萌了。为了我喵星球的伟大复兴，我今天要更加努力（卖萌）~",
 "short_title": "广州",
 "status": 0,
 "template": "",
 "title": "喵~有猫星人陪伴的咖啡时光",
 "type": "post",
 "updated_at": 1443522066,
 "url": "http://guozhoumo.liwushuo.com/posts/2083"
 */