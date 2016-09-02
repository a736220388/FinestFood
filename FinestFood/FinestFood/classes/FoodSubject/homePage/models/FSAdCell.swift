//
//  FSAdCell.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FSAdCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var lastIndex:Int?
    var timer:NSTimer?
    var convertValueClosure:((NSNumber,String)->Void)?
    
    var scrollViewArray:NSMutableArray?{
        didSet{
            let lastModel = scrollViewArray?.lastObject
            let firstModel = scrollViewArray?.firstObject
            scrollViewArray?.addObject(firstModel!)
            scrollViewArray?.insertObject(lastModel!, atIndex: 0)
            showList()
        }
    }
    func showList(){
        for subView in scrollView.subviews{
            subView.removeFromSuperview()
        }
        let count = scrollViewArray?.count
        if count > 0{
            let containerView = UIView.createUIView()
            scrollView.addSubview(containerView)
            containerView.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.edges.equalTo((self?.scrollView)!)
                make.height.equalTo((self?.scrollView)!)
                })
            var lastView:UIView? = nil
            for i in 0..<count!{
                let model = scrollViewArray![i] as! FSScrollViewDataModel
                let tmpImageView = UIImageView.createImageView(nil)
                let url = NSURL(string: model.image_url!)
                tmpImageView.kf_setImageWithURL(url, placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                containerView.addSubview(tmpImageView)
                tmpImageView.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(containerView)
                    make.width.equalTo(kScreenWidth)
                    if i == 0{
                        make.left.equalTo(containerView)
                    }else{
                        make.left.equalTo((lastView?.snp_right)!)
                    }
                })
                lastView = tmpImageView
            }
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo((lastView?.snp_right)!)
            })
            pageControl.numberOfPages = count! - 2
            scrollView.delegate = self
            scrollView.pagingEnabled = true
            let g = UITapGestureRecognizer(target: self, action: #selector(tapAction))
            scrollView.addGestureRecognizer(g)
        }
        if timer == nil{
            timer = NSTimer(timeInterval: 3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSDefaultRunLoopMode)
        }
    }
    func tapAction(){
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        let model = scrollViewArray![index] as! FSScrollViewDataModel
        
        self.convertValueClosure!(model.target_id!,"AD")
    }
    func timerAction(){
        UIView.beginAnimations("animate1", context: nil)
        UIView.setAnimationDuration(1)
        UIView.setAnimationRepeatCount(1)
        UIView.setAnimationDelegate(self)
        scrollView.contentOffset.x += kScreenWidth
        scrollViewDidEndDecelerating(scrollView)
        UIView.commitAnimations()
        
    }
    class func createAdCell(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withDataArray array:NSMutableArray,closure:((NSNumber,String)->Void)?)->FSAdCell{
        let cellId = "adCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FSAdCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("FSAdCell", owner: nil, options: nil).last as? FSAdCell
        }
        cell?.convertValueClosure = closure
        cell?.scrollViewArray?.removeLastObject()
        cell?.scrollViewArray?.removeObjectAtIndex(0)
        cell?.scrollViewArray = array
        return cell!
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension FSAdCell:UIScrollViewDelegate{
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
//        pageControl.currentPage = index
//    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        if lastIndex == nil{
            let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
            pageControl.currentPage = index
            lastIndex = index
        }else{
            if index == 0 && (index < self.lastIndex) {
                scrollView.contentOffset = CGPointMake(kScreenWidth*CGFloat(self.scrollViewArray!.count-2), 0)
                self.lastIndex = (self.scrollViewArray?.count)!-1
            }else if (index == (self.scrollViewArray?.count)!-1)  && (index > self.lastIndex){
                scrollView.contentOffset = CGPointMake(kScreenWidth, 0)
                self.lastIndex = 0
            }else{
                self.lastIndex = index
            }
            self.pageControl?.currentPage = self.lastIndex!-1
        }
    }
    
    
    
}
