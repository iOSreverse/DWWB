//
//  ComposeTextView.swift
//  DWWB
//
//  Created by xmg on 16/4/14.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTextView: UITextView {
    // MARK: - 懒加载属性
    lazy var placeHolderLabel : UILabel = UILabel()

    // MARK: - 构造函数
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupUI()
    }
}


// MARK: - 设置UI界面
extension ComposeTextView {
    private func setupUI() {
        // 1.添加子控件
        addSubview(placeHolderLabel)

        // 2.设置frame
        placeHolderLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(8)
            make.left.equalTo(10)
        }

        // 3.设置placeHolderLabel属性
        placeHolderLabel.textColor = UIColor.lightGrayColor()
        placeHolderLabel.font = font

        // 4.设置placeHolderLabel文字
        placeHolderLabel.text = "分享新鲜事...."

        // 5.设置内容的边内距
        textContainerInset = UIEdgeInsets(top: 6, left: 7, bottom: 0, right: 7)
    }
}