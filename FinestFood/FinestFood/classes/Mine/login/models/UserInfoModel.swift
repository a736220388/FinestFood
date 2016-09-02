//
//  UserInfoModel.swift
//  FinestFood
//
//  Created by qianfeng on 16/9/2.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class UserInfoModel: NSObject {
    var avatar_url:String?
    var can_mobile_login:NSNumber?
    var guest_uuid:NSNumber?
    var id:NSNumber?
    var mobile:String?
    var nickname:String?
    var role:NSNumber?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    /*
     "id": 5008184, "role": 0, "guest_uuid": <null>, "can_mobile_login": 1, "avatar_url": , "nickname": 18550217032, "mobile": 18550217032
     */
}
