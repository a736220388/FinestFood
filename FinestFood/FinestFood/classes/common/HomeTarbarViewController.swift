//
//  HomeTarbarViewController.swift
//  FinestFood
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HomeTarbarViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let mainCtrl = appDele.window?.rootViewController
        if mainCtrl?.isKindOfClass(MainTabBarController.self) == true{
            let ctrl = mainCtrl as! MainTabBarController
            ctrl.bgView!.hidden = false
        }
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let mainCtrl = appDele.window?.rootViewController
        if mainCtrl?.isKindOfClass(MainTabBarController.self) == true{
            let ctrl = mainCtrl as! MainTabBarController
            ctrl.bgView!.hidden = false
        }
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let mainCtrl = appDele.window?.rootViewController
        if mainCtrl?.isKindOfClass(MainTabBarController.self) == true{
            let ctrl = mainCtrl as! MainTabBarController
            ctrl.bgView!.hidden = true
        }
    }

}
