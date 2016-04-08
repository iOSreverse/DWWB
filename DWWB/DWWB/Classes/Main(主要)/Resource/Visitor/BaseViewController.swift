//
//  BaseViewController.swift
//  DWWB
//
//  Created by xmg on 16/4/5.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit


class BaseViewController: UITableViewController {

    // MARK: - 懒加载属性
    lazy var visitorView : VisitorView = VisitorView.visitorView()

    // MARK: - 定义变量
    var isLogin : Bool = false

    // MARK: - 系统回调函数
    override func loadView() {

        //1.从沙盒中读取归档的信息
        //1.1.获取沙盒路径
        var accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        accountPath = (accountPath as NSString).stringByAppendingPathComponent("account.plist")

        //1.2.读取信息
        let account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
        if let account = account {

            //1.3取出过期日期 : 当前日期
            if let expiresDate = account.expires_date {
                isLogin = expiresDate.compare(NSDate()) == NSComparisonResult.OrderedDescending
            }
        }
        // 判断要加载哪一个view
        isLogin ? super.loadView() : setupVisitorView()
    }

    override func viewDidLoad() {
         super.viewDidLoad()

        setupNavigationItems()
    }
}




// MARK: - 设置UI界面
extension BaseViewController {
    ///设置访客视图
    private func setupVisitorView() {
        view = visitorView

//        监听访客视图中`注册`和`登录`按钮的点击
        visitorView.registerBtn.addTarget(self, action: "registerBtnClick", forControlEvents: .TouchUpInside)
        visitorView.loginBtn.addTarget(self, action: "loginBtnClick", forControlEvents: .TouchUpInside)
        }

//        设置导航栏左右的Item
        private func setupNavigationItems() {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "registerBtnClick")
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: "loginBtnClick")


    }
}


// MARK: - 事件监听
extension BaseViewController {
    @objc private func registerBtnClick() {
        print("registerBtnClick")
        
    }

    @objc private func loginBtnClick() {
//        1.创建授权控制器
        let oauthVc = OAuthViewController()

//        2.包装导航栏控制器
        let oauthNav = UINavigationController(rootViewController: oauthVc)

//        3.弹出控制器
        presentViewController(oauthNav, animated: true, completion: nil)

    }
}
