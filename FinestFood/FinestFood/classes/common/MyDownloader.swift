//
//  MyDownloader.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MyDownloader: NSObject {
    var didFailWithError:((NSError)->Void)?
    var didFinishWithData:((NSData)->Void)?
    func downloadWithUrlString(urlString:String){
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            if error != nil{
                self.didFailWithError!(error!)
            }else{
                let httpRes = response as! NSHTTPURLResponse
                if httpRes.statusCode == 200{
                    self.didFinishWithData!(data!)
                }else{
                    let error = NSError(domain: "\(httpRes.statusCode)", code: 0, userInfo: nil)
                    self.didFailWithError?(error)
                }
            }
        }
        task.resume()
    }
    func downloadWithPostUrlString(urlString:String,paramString:String){
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        let data = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = data
        request.HTTPMethod = "POST"
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            if error != nil{
                self.didFailWithError!(error!)
            }else{
                let httpRes = response as! NSHTTPURLResponse
                if httpRes.statusCode == 200{
                    self.didFinishWithData!(data!)
                }else{
                    self.didFinishWithData!(data!)
                }
            }
        }
        task.resume()
    }
}
