//
//  OAuthViewController.swift
//  DWWB
//
//  Created by xmg on 16/4/7.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit


class OAuthViewController: UIViewController {

    // MARK: - 控件的属性
    @IBOutlet weak var webView: UIWebView!


    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

//        1.设置导航栏的内容
        setupNavigationBar()

//        加载网页
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.mvptop.com")!))

    }

}

// MARK: - 设置UI界面
extension OAuthViewController {
    ///设置发布按钮
    private func setupNavigationBar() {
//        1.设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "closeItemClick")
//        2.设置右侧的item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .Plain, target: self, action: "fillItemClick")

//        3.设置标题
        title = "登录页面"
    }
}


// MARK: - 事件监听函数
extension OAuthViewController {
    @objc private func closeItemClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @objc private func fillItemClick() {
        print("fillItemClick")
    }
}