//
//  MainViewController.swift
//  DWWB
//
//  Created by xmg on 16/4/3.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    // MARK: - 懒加载属性
    private lazy var composeBtn : UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")


    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        setupComposeBtn()
    }

}

// MARK: - 设置UI界面
extension MainViewController {
    ///设置发布按钮
    private func setupComposeBtn() {
//        1.将composeBtn添加到tabbar中
        tabBar.addSubview(composeBtn)


//        2.设置位置
        composeBtn.center = CGPointMake(tabBar.center.x, tabBar.bounds.size.height * 0.5)



    }
}



