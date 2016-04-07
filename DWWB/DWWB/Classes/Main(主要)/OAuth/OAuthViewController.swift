//
//  OAuthViewController.swift
//  DWWB
//
//  Created by xmg on 16/4/7.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit
import SVProgressHUD


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

// MARK: - webView的delegate方法
extension OAuthViewController : UIWebViewDelegate {

    //    webView开始加载网页
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }

//    webView网页加载完成
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }

//    webView加载网页失败
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        SVProgressHUD.dismiss()
    }




//    当准备加载某一个页面时,会执行该方法
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {

//        1.获取加载网页的NSURL
        guard let url = request.URL else {
            return true
        }

//        2.获取url中的字符串
        let urlString = url.absoluteString

//        3.判断该字符串中是否包含code
        guard urlString.containsString("code=") else {
            return true
        }

//        4.将code截取出来
        let code = urlString.componentsSeparatedByString("code=").last!

        //5.请求accessToken
        loadAccessToken(code)

        return false
    }
}

// MARK: - 请求数据
extension OAuthViewController {
    ///请求AccessToken
    private func loadAccessToken(code : String) {
        NetworkTools.shareInstance.loadAccessToken(code) { (result, error) -> () in
            //1.错误校验
            if error != nil {
                print(error)
                return
            }

            //2.拿到结果
            guard let accountDict = result else {
                print("没有获取授权后的数据")
                return
            }

            //3.将字典转成模型
            let account = UserAccount(dict: accountDict)

            print(account)

        }
    }

}




































