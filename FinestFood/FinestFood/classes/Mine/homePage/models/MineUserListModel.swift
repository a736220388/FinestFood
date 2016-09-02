//
//  MineUserListModel.swift
//  FinestFood
//
//  Created by qianfeng on 16/9/2.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MineUserListModel: NSObject {
    
    var cover_image_url:NSString?
    var created_at:NSNumber?
    var desc:NSString?
    var head_image_url:NSString?
    var id:NSNumber?
    var items_count:NSNumber?
    var name:NSString?
    var url:NSString?
    var user_id:NSNumber?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        if key == "description" {
            self.desc = value as? NSString
        }
    }
}
/*
 {
 "code": 200,
 "data": {
 "favorite_lists": [
 {
 "cover_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150928/vermflj1e_w.png-w720",
 "created_at": 1472741755,
 "description": null,
 "head_image_url": null,
 "id": 8386,
 "items_count": 2,
 "name": "\u6211\u559c\u6b22\u7684\u5546\u54c1",
 "public": true,
 "updated_at": 1472741755,
 "url": "http://guozhoumo.liwushuo.com/favorite_lists/8386",
 "user_id": 5008184
 }
 ],
 "paging": {
 "next_url": "http://api.guozhoumoapp.com/v1/users/me/favorite_lists?limit=20&offset=20"
 }
 },
 "message": "OK"
 }
 */