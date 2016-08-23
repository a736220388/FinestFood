//
//  FoodListItemModel.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FoodListItemModel: NSObject {
    var brand_id:NSNumber?
    var brand_order:NSNumber?
    var category_id:NSNumber?
    var cover_image_url:String?
    var created_at:NSNumber?
    var editor_id:NSNumber?
    var favorites_count:NSNumber?
    var id:NSNumber?
    var image_urls:NSArray?
    var is_favorite:Bool?
    var name:String?
    var post_ids:NSArray?
    var price:String?
    var purchase_id:String?
    var purchase_status:NSNumber?
    var purchase_type:NSNumber?
    var purchase_url:String?
    var subcategory_id:NSNumber?
    var updated_at:NSNumber?
    var url:String?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
/*
 "brand_id": null,
 "brand_order": null,
 "category_id": null,
 "cover_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150928/vermflj1e_w.png-w720",
 "created_at": 1443431372,
 "description": "2015年10月，被华南地区动漫粉丝冠以....
 "editor_id": 1022,
 "favorites_count": 264,
 "id": 767,
 "image_urls": [
 "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150928/vermflj1e_w.png-w720"
 ],
 "is_favorite": false,
 "name": "CICF EXPO 2015（中国国际漫画节动漫游戏展）",
 "post_ids": [],
 "price": "0.00",
 "purchase_id": null,
 "purchase_status": 1,
 "purchase_type": 0,
 "purchase_url": "http://www.cicfexpo.com/contents/23/1058.html",
 "subcategory_id": null,
 "updated_at": 1443431372,
 "url": "http://guozhoumo.liwushuo.com/items/767"
 */