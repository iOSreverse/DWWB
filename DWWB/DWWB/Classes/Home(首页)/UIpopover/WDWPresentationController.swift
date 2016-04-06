//
//  WDWPresentationController.swift
//  DWWB
//
//  Created by xmg on 16/4/6.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

class WDWPresentationController: UIPresentationController {
    // MARK: - 对外提供属性
    var presentedFrame : CGRect = CGRectZero


    // MARK: - 懒加载属性
    private lazy var coverView : UIView = UIView()

    // MARK: - 系统回调函数
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()

//        1.设置弹出view的尺寸
        presentedView()?.frame = CGRect(x: 100, y: 55, width: 180, height: 250)

//        2.添加蒙版
        setupCoverView()

    }

}

// MARK: - 设置UI界面相关
extension WDWPresentationController {
    private func setupCoverView() {
//        1.添加蒙版
        containerView?.insertSubview(coverView, atIndex: 0)

//        2.设置蒙版的属性
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = containerView!.bounds

//        3.添加手势
        let tapGes = UITapGestureRecognizer(target: self, action: "coverViewClick")
        coverView.addGestureRecognizer(tapGes)

    }
}

// MARK: - 事件监听
extension WDWPresentationController {
    @objc private func coverViewClick() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }

}

