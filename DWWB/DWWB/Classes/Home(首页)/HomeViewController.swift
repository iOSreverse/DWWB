//
//  HomeViewController.swift
//  DWWB
//
//  Created by xmg on 16/4/3.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: BaseViewController {
    
    // MARK: - 懒加载属性
    private lazy var titleBtn : TitleButton = TitleButton()
    private lazy var popoverAnimator : PopoverAnimator = PopoverAnimator {[weak self] (presented) -> () in
        self?.titleBtn.selected = presented
    }

    private lazy var viewModels : [StatusViewModel] = [StatusViewModel]()

    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

//        1.没有登录时设置的内容
        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
//        2.设置导航栏的内容
        setupNavigationBar()

        // 3.请求数据
        loadStatuses()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }

}

// MARK: - 设置UI界面
extension HomeViewController {
    private func setupNavigationBar() {
//        1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")

//        2.设置右的Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")

//        3.设置titleView
        titleBtn.setTitle("iOSreverse", forState: .Normal)
        titleBtn.addTarget(self, action: "titleBtnClick:", forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleBtn
    }
}


// MARK: - 事件监听的函数
extension HomeViewController {
    @objc private func titleBtnClick(titleBtn : TitleButton) {
//        1.改变按钮的状态
        titleBtn.selected = !titleBtn.selected

//        2.创建弹出的控制器
        let popoverVc = PopoverViewController()

//        3.设置控制器的modal样式
        popoverVc.modalPresentationStyle = .Custom

        //4.设置转场的代理
        popoverVc.transitioningDelegate = popoverAnimator
        popoverAnimator.presentedFrame = CGRect(x: 100, y: 55, width: 180, height: 250)

//        弹出控制器
        presentViewController(popoverVc, animated: true, completion: nil)


    }
}

// MARK: - 请求数据
extension HomeViewController {
    private func loadStatuses() {
        NetworkTools.shareInstance.loadStatuses { (result, error) -> () in
            // 1.错误校验
            if error != nil {
                print(error)
                return
            }

            // 2.获取可选类型中的数据
            guard let resultArray = result else {
                return
            }

            // 3.遍历微博对应的字典
            for statusDict in resultArray {
                let status = Status(dict: statusDict)
                let viewModel = StatusViewModel(status: status)
                self.viewModels.append(viewModel)
            }

            // 4.缓存图片
            self.cacheImages(self.viewModels)


        }
    }

    private func cacheImages(viewModels : [StatusViewModel]) {
        // 0.创建group
        let group = dispatch_group_create()

        // 1.缓存图片
        for viewmodels in viewModels {
            for picURL in viewmodels.picURLs {
                dispatch_group_enter(group)
                SDWebImageManager.sharedManager().downloadImageWithURL(picURL, options: [], progress: nil, completed: { (_, _, _, _, _) -> Void in
                    dispatch_group_leave(group)
                })
            }
        }
        // 2.刷新表格
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            self.tableView.reloadData()
        }
    }
}


// MARK: - tableViewd的数据源方法
extension HomeViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 1.创建cell
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell") as! HomeViewCell

        // 2.给cell设置数据
        cell.viewModel = viewModels[indexPath.row]



        return cell
    }

}


