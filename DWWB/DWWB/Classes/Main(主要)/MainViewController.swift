//
//  MainViewController.swift
//  DWWB
//
//  Created by xmg on 16/4/3.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

        // MARK: -  懒加载属性
        private lazy var imageNames : [String] = ["tabbar_home", "tabbar_message_center", "", "tabbar_discover", "tabbar_profile"]
        private lazy var composeBtn : UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")


        // MARK: - 系统函数回
    override func viewDidLoad() {
        super.viewDidLoad()

        setupComposeBtn()
    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        adjustItems()
    }


}


extension MainViewController {

    ///调整的tabbar
    private func adjustItems() {
        for i in 0..<tabBar.items!.count {
//            1.取出item
            let item = tabBar.items![i]

//            2.判断如果是下标值为2,那么不可以和用户交互
            if i == 2 {
            item.enabled = false
            continue

            }

//            3.设置item的选中图片
            item.selectedImage = UIImage(named: imageNames[i] + "_highlighted")

        }
    }

    /// 添加发布按钮
    private func setupComposeBtn() {
//        1.将按钮添加到tabbar中
        tabBar.addSubview(composeBtn)

//        2.设置发布按钮的位置
        composeBtn.center = CGPoint(x: tabBar.bounds.width * 0.5, y: tabBar.bounds.height * 0.5)

//        3.监听按钮的点击
        composeBtn.addTarget(self, action: "composeBtnClick", forControlEvents: .TouchUpInside)
    }
}
extension MainViewController {
    @objc private func composeBtnClick() {
        print("composeBtnClick")
    }
}
