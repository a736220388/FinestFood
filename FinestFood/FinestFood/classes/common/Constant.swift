//
//  Constant.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

public let kScreenWidth = UIScreen.mainScreen().bounds.width
public let kScreenHeight = UIScreen.mainScreen().bounds.height

public let FSScrollViewUrl = "http://api.guozhoumoapp.com/v1/banners?channel=iOS"
//专题集合(体验课...)
public let FSScrollViewListlUrl = "http://api.guozhoumoapp.com/v1/collections/%d/posts?gender=%d&generation=%d&limit=%d&offset=%d"
public let FSSearchWordUrl = "http://api.guozhoumoapp.com/v1/search/hot_words"
public let FSSearchItemResultUrl = "http://api.guozhoumoapp.com/v1/search/item?keyword=%@&limit=%d&offset=%d&sort="
public let FSSearchPostResultUrl = "http://api.guozhoumoapp.com/v1/search/post?keyword=%@&limit=%d&offset=%d&sort="
public let FSFoodListUrl = "http://api.guozhoumoapp.com/v1/channels/2/items?gender=%d&generation=%d&limit=%d&offset=%d"
//宅家
public let FSFoodMoreListUrl = "http://api.guozhoumoapp.com/v1/channels/%d/items?limit=%d&offset=%d"
public let FSFoodDetailUrl = "http://api.guozhoumoapp.com/v1/posts/%d"


public let FLFoodListUrl = "http://api.guozhoumoapp.com/v2/items?gender=%d&generation=%d&limit=%d&offset=%d"
public let FLFoodDetailUrl = "http://api.guozhoumoapp.com/v2/items/%d/comments?limit=%d&offset=%d"//单品中商品的detail
public let FLFoodSearchDetailUrl = "http://api.guozhoumoapp.com/v2/items/%d"//搜索中商品的detail

public let CGHomeOutUrl = "http://api.guozhoumoapp.com/v1/channel_groups/all"
//查看全部
public let CGSubjectUrl = "http://api.guozhoumoapp.com/v1/collections?limit=%d&offset=%d"


//登录
public let MineLoginUrl = "http://api.guozhoumoapp.com/v1/account/signin"
//postBody:mobile=18550217023&password=123456

//注册
public let MineRegisterUrl = "http://api.guozhoumoapp.com/v1/account/mobile_exist"
//post:mobile=18550217032
//{
//        "code": 200,
//        "data": {
//            "exist": false
//        },
//        "message": "OK"
//}


//http://api.guozhoumoapp.com/v1/account/sms_token
//    {
//        "code": 200,
//        "data": {
//            "token": "xwg6e9f6z5"
//        },
//        "message": "OK"
//}


//http://api.guozhoumoapp.com/v1/account/send_verification_code
//access_token=I7iUQTM%2Bbmpucs6rWeMAAMoCFx4%3D&mobile=18550217032
//    {
//        "code": 200,
//        "data": {},
//        "message": "OK"
//}




/*
 精选
 
 滚动视图
 http://api.guozhoumoapp.com/v1/banners?channel=iOS
 滚动视图详情
 1,体验课:http://api.guozhoumoapp.com/v1/collections/4/posts?gender=1&generation=0&limit=20&offset=0
 2,下厨房:http://api.guozhoumoapp.com/v1/collections/3/posts?gender=1&generation=0&limit=20&offset=0
 3,来一发:http://api.guozhoumoapp.com/v1/collections/1/posts?gender=1&generation=0&limit=20&offset=0
 4,周末宅家:http://api.guozhoumoapp.com/v1/collections/2/posts?gender=1&generation=0&limit=20&offset=0
 
 内容
 http://api.guozhoumoapp.com/v1/channels/2/items?gender=1&generation=0&limit=20&offset=0
 
 搜索
 http://api.guozhoumoapp.com/v1/search/hot_words?
 商品:http://api.guozhoumoapp.com/v1/search/item?keyword=%E6%89%8B%E5%B7%A5&limit=20&offset=0&sort=
 攻略:http://api.guozhoumoapp.com/v1/search/post?keyword=%E4%B8%8A%E6%B5%B7&limit=20&offset=0&sort=
 
 周末逛店
 内容:http://api.guozhoumoapp.com/v1/channels/12/items?limit=20&offset=0
 
 尝美食
 内容:http://api.guozhoumoapp.com/v1/channels/15/items?limit=20&offset=0
 
 体验课
 内容:http://api.guozhoumoapp.com/v1/channels/13/items?limit=20&offset=0
 
 周边游
 内容:http://api.guozhoumoapp.com/v1/channels/14/items?limit=20&offset=0
 
 单品
 内容:http://api.guozhoumoapp.com/v2/items?gender=1&generation=0&limit=20&offset=0

 宅家,出门 http://api.guozhoumoapp.com/v1/channel_groups/all
 专题集合 http://api.guozhoumoapp.com/v1/collections?limit=6&offset=0
 
 */