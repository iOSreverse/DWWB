//
//  BaseViewController.swift
//  DWWB
//
//  Created by xmg on 16/4/4.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    //    MARK: - 懒加载
    lazy var visitorView : VisitorView = VisitorView.visitorView()

    //    MARK: - 懒加载
    var isLogin : Bool = false

    //    MARK: - 懒加载
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


extension BaseViewController {
    ///加载访客视图
    private func setupVisitorView() {
        view = visitorView
    }
}