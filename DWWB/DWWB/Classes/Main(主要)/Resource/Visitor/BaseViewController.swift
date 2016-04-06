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
        print("loginBtnClick")

    }
}
