//
//  VisitorView.swift
//  DWWB
//
//  Created by xmg on 16/4/5.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    // MARK: - 提供快速通过xib创建的类方法
    class func visitorView() -> VisitorView {
        return NSBundle.mainBundle().loadNibNamed("VisitorView", owner: nil, options: nil).first as! VisitorView
    }

    // MARK: - 控件的属性
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!

    // MARK: - 自定义函数
    func setupVisitorViewInfo(iconName : String, title : String) {
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        rotationView.hidden = true
    }

    func addRotationAnim() {
//        1.创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")

//        2.设置动画的属性
        rotationAnim.fromValue = 0
        rotationAnim.toValue = M_PI * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 5
        rotationAnim.removedOnCompletion = false

//        3.将动画添加到layer中
        rotationView.layer.addAnimation(rotationAnim, forKey: nil)
    }



}








