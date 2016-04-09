//
//  AppDelegate.swift
//  DWWB
//
//  Created by xmg on 16/4/2.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var defaultViewController : UIViewController? {
        let isLogin = UserAccountViewModel.shareIntance.isLogin
        return isLogin ? WelcomeViewController() : UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

//        设置全局颜色
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()

        // 创建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = defaultViewController
        window?.makeKeyAndVisible()

        return true
    }





}

