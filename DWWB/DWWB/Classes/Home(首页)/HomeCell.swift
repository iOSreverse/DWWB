//
//  HomeCell.swift
//  DWWB
//
//  Created by xmg on 16/4/10.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

private let edgeMargin : CGFloat = 15

class HomeViewCell: UITableViewCell {
    // MARK: - 约束的属性
    @IBOutlet weak var contentLabelWcons: NSLayoutConstraint!

    // MARK: - 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()

        // 设置微博正文的宽度约束
        contentLabelWcons.constant = UIScreen.mainScreen().bounds.width - 2 * edgeMargin
    }
}
