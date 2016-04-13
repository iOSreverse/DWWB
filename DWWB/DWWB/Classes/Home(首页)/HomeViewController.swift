//
//  HomeViewController.swift
//  DWWB
//
//  Created by xmg on 16/4/3.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

class HomeViewController: BaseViewController {
    
    // MARK: - 懒加载属性
    private lazy var titleBtn : TitleButton = TitleButton()
    private lazy var popoverAnimator : PopoverAnimator = PopoverAnimator {[weak self] (presented) -> () in
        self?.titleBtn.selected = presented
    }

    private lazy var viewModels : [StatusViewModel] = [StatusViewModel]()
    private lazy var tipLabel : UILabel = UILabel()

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
        tableView.estimatedRowHeight = 200

        // 4.布局header
        setupHeaderView()

        setupFooterView()
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

    private func setupHeaderView() {
        // 1.创建headerView
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "loadNewStatus")

        // 2.设置header的属性
        header.setTitle("下拉刷新", forState: .Idle)
        header.setTitle("松手刷新", forState: .Pulling)
        header.setTitle("加载中...", forState: .Refreshing)

        // 3.设置tableView的header
        tableView.mj_header = header

        // 4.进入刷新状态
        tableView.mj_header.beginRefreshing()
    }

    private func setupFooterView() {
        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: "loadMoreStatus")
    }

    private func setupTipLabel() {
        // 1.将tipLabel添加父控件
        navigationController?.navigationBar.insertSubview(tipLabel, atIndex: 0)

        // 2.设置tipLabel的frame
        tipLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 32)

        // 3.设置tipLabel的属性
        tipLabel.backgroundColor = UIColor.orangeColor()
        tipLabel.textColor = UIColor.whiteColor()
        tipLabel.font = UIFont.systemFontOfSize(14)
        tipLabel.textAlignment = .Center
        tipLabel.hidden = true
    }
}


// MARK: - 事件监听的函数
extension HomeViewController {
    @objc private func titleBtnClick(titleBtn : TitleButton) {
//        1.创建弹出的控制器
        let popoverVc = PopoverViewController()

//        2.设置控制器的modal样式
        popoverVc.modalPresentationStyle = .Custom

        //3.设置转场的代理
        popoverVc.transitioningDelegate = popoverAnimator
        popoverAnimator.presentedFrame = CGRect(x: 100, y: 55, width: 180, height: 250)

//        4.弹出控制器
        presentViewController(popoverVc, animated: true, completion: nil)


    }
}

// MARK: - 请求数据
extension HomeViewController {
    /// 加载最新的数据
    @objc private func loadNewStatus() {
        loadStatuses(true)
    }

    /// 加载最新的数据
    @objc private func loadMoreStatus() {
        loadStatuses(false)
    }

    /// 加载微博数据
    private func loadStatuses(isNewData : Bool) {

        // 1.获取since_id/max_id
        var since_id = 0
        var max_id = 0
        if isNewData {
            since_id = viewModels.first?.status?.mid ?? 0
        } else {
            max_id = viewModels.last?.status?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }

        // 请求数据
        NetworkTools.shareInstance.loadStatuses(since_id, max_id: max_id) { (result, error) -> () in
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
            var tempViewModel = [StatusViewModel]()
            for statusDict in resultArray {
                let status = Status(dict: statusDict)
                let viewModel = StatusViewModel(status: status)
                tempViewModel.append(viewModel)
            }

            // 4.将数据放入到成员变量的数组中
            if isNewData {
                self.viewModels = tempViewModel + self.viewModels
            } else {
                self.viewModels += tempViewModel
            }

            // 5.缓存图片
            self.cacheImages(tempViewModel)


        }
    }

    /// 缓存图片
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
            // 刷新表格
            self.tableView.reloadData()

            // 停止刷新
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()

            // 显示提示的Label
            self.showTipLabel(viewModels.count)

        }
    }

    /// 显示提示的Label
    private func showTipLabel(count : Int) {
        // 1.设置tipLabel的属性
        tipLabel.hidden = false
        tipLabel.text = count == 0 ? "没有新数据" : "\(count) 条形微博"

        // 2.执行动画
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.tipLabel.frame.origin.y = 44
            }) { (_) -> Void in
                UIView.animateWithDuration(1.0, delay: 1.5, options: [], animations: { () -> Void in
                    self.tipLabel.frame.origin.y = 10
                    }, completion: { (_) -> Void in
                        self.tipLabel.hidden = true
                })
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

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // 1.获取模型对象
        let viewModel = viewModels[indexPath.row]

        return viewModel.cellHeight
    }

}


