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
        loadPage()

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

    private func loadPage() {
//        1.获取登录页面的URLString
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"

//        2.创建对应NSURL
        guard let url = NSURL(string: urlString) else {
            return
        }

//        3.创建NSURLRequest
        let request = NSURLRequest(URL: url)

//        4.加载request对象
        webView.loadRequest(request)
    }
}


// MARK: - 事件监听函数
extension OAuthViewController {
    @objc private func closeItemClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @objc private func fillItemClick() {
//        1.书写js代码 : 
        let jsCode = "document.getElementById('userId').value='18533675618';document.getElementById('passwd').value='weibo386675';"
//        2.执行js代码
        webView.stringByEvaluatingJavaScriptFromString(jsCode)
    }
}