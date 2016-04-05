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
    }
}

extension BaseViewController {
    private func setupVisitorView() {
        view = visitorView
    }
}
