//
//  MainViewController.swift
//  DWWB
//
//  Created by xmg on 16/4/3.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        1.取出json文件
        let jsonPath = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)!


//        2.读取json数据
        guard let jsonData = NSData(contentsOfFile: jsonPath) else {
            return
        }
//        3.将data转成字典
        guard let dicts = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableLeaves) as! [[String : AnyObject]] else {
            return
        }

//        4.遍历字典
        for dict in dicts {
//            1.取出控制器的名称
            guard let childVcName = dict["vcName"] as? String else {
                continue
            }
//            2.取出标题
            guard let title = dict["title"] as? String else {
                continue
            }
//            3.取出图片名称
            guard let imageName = dict["imageName"] as? String else {
                continue
            }

            addChildViewController(childVcName, title: title, imageName: imageName)

        }




    }

    private func addChildViewController(childVcName: String, title : String, imageName : String) {

//        1.获取命名空间
        guard let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else{
            print("没有获取到命名空间")
            return
        }

//        2.创建子控制器
        guard let AnyClass = NSClassFromString(nameSpace + "." + childVcName) else {
            print("没有创建出对应的class")
            return
        }
//        3.通过class创建对象
        guard let ChildVcClass = AnyClass as? UIViewController.Type else {
            print("没有转成控制器")
            return
        }

//        4.创建子控制器对象
        let childVc = ChildVcClass.init()

//        5.设置子控制器的属性
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
        childVc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")

//        6.包装导航栏控制器
        let childNav = UINavigationController(rootViewController: childVc)

//        7.添加控制器
        addChildViewController(childNav)
    }



}
