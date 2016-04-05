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
    private lazy var imageNames = ["tabbar_home", "tabbar_message_center", "","tabbar_discover", "tabbar_profile"]


    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
    }




    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

            //           1.遍历所有的item
        for i in 0..<tabBar.items!.count {
            //            2.获取item
            let item = tabBar.items![i]

            //            3.如果下标是2,则该item不可以和用户交互
            if i == 2 {
                item.enabled = false
                continue
            }

            //            4.设置其他item的选中时候的图片
            item.selectedImage = UIImage(named: imageNames[i] + "_highlighted")
            
        }
        
        
}

}