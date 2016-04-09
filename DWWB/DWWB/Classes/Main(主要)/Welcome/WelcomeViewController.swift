//
//  WelcomeViewController.swift
//  DWWB
//
//  Created by xmg on 16/4/8.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {

    // MARK: - 拖线的属性
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var iconView: UIImageView!

    // MARK: - 系统回调函数
    override func viewDidLoad() {
         super.viewDidLoad()
        //0.设置头像
        let profileURLString = UserAccountViewModel.shareIntance.account?.avatar_large

        let url = NSURL(string: profileURLString ?? "")
        iconView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar_default_big"))

        //1.改变约束的值
        iconViewBottomCons.constant = UIScreen.mainScreen().bounds.height - 200

        //2.执行动画
        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (_) -> Void in
                UIApplication.sharedApplication().keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }
}
