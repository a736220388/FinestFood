//
//  FLDetailModel.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FLDetailModel: NSObject {
    var content:String?
    var created_at:NSNumber?
    var id:NSNumber?
    var item_id:NSNumber?
    var required_comment:FLRepliedCommentModel?
    var required_user:FLRepliedUserModel?
    var reply_to_id:NSNumber?
    var show:Bool?
    var status:NSNumber?
    var user:FLUserModel?
}
class FLRepliedCommentModel:NSObject{
    var content:String?
    var created_at:NSNumber?
    var id:NSNumber?
    var item_id:NSNumber?
    var reply_to_id:NSNumber?
    var show:Bool?
    var status:NSNumber?
    var user_id:NSNumber?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
class FLRepliedUserModel:NSObject{
    var avatar_url:String?
    var can_mobile_login:Bool?
    var guest_uuid:NSObject?
    var id:NSNumber?
    var nickname:String?
    var role:NSNumber?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
class FLUserModel:NSObject{
    var avatar_url:String?
    var can_mobile_login:Bool?
    var guest_uuid:NSObject?
    var id:NSNumber?
    var nickname:String?
    var role:NSNumber?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
/*
 "content": "7",
 "created_at": 1470379724,
 "id": 61,
 "item_id": 767,
 "replied_comment": {
 "content": "   8",
 "created_at": 1466502373,
 "id": 57,
 "item_id": 767,
 "reply_to_id": 17,
 "show": true,
 "status": 1,
 "user_id": 5006915
 },
 "replied_user": {
 "avatar_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/avatar/20160621/2z1jju5t0_i.png-w180",
 "can_mobile_login": false,
 "guest_uuid": null,
 "id": 5006915,
 "nickname": "七.七",
 "role": 0
 },
 "reply_to_id": 57,
 "show": true,
 "status": 1,
 "user": {
 "avatar_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/avatar/160802/cba22700d_a.png-w180",
 "can_mobile_login": false,
 "guest_uuid": null,
 "id": 5007506,
 "nickname": "太阳和风与旅行者",
 "role": 0
 }
 */

