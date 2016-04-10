//
//  HomeCell.swift
//  DWWB
//
//  Created by xmg on 16/4/10.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit
import SDWebImage

private let edgeMargin : CGFloat = 15
private let itemMargin : CGFloat = 10

class HomeViewCell: UITableViewCell {

    // MARK: - 控件属性
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    // MARK: - 约束的属性
    @IBOutlet weak var contentLabelWcons: NSLayoutConstraint!
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!

    // MARK: - 自定义属性
    var viewModel : StatusViewModel? {
        didSet {
            // 1.nil值校验
            guard let viewModel = viewModel else {
                return
            }

            // 2.设置头像
            iconView.sd_setImageWithURL(viewModel.profileURL, placeholderImage: UIImage(named: "avatar_default_small"))

            // 3.设置认证的图标
            verifiedView.image = viewModel.verifiedImage

            // 4.昵称
            screenNameLabel.text = viewModel.status?.user?.screen_name

            // 5.会员图标
            vipView.image = viewModel.vipImage

            // 6.设置时间的Label
            timeLabel.text = viewModel.createAtText

            // 7.设置来源
            contentLabel.text = viewModel.status?.text

            // 8.设置昵称的文字颜色
            screenNameLabel.textColor = viewModel.vipImage == nil ? UIColor.blackColor() : UIColor.orangeColor()

            // 9.计算picView的宽度和高度的约束
            let picViewSize = calculatePicViewSize(viewModel.picURLs.count)
            picViewHCons.constant = picViewSize.height
            picViewWCons.constant = picViewSize.width
        }
    }

    // MARK: - 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()

        // 设置微博正文的宽度约束
        contentLabelWcons.constant = UIScreen.mainScreen().bounds.width - 2 * edgeMargin
    }
}

// MARK: - 计算方法
extension HomeViewCell {
    private func calculatePicViewSize(count : Int) -> CGSize {
        // 1.没有配图
        if count == 0 {
            return CGSizeZero
        }

        // 2.计算出来imageViewWH
        let imageViewWH = (UIScreen.mainScreen().bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3

        // 3.四张配图
        if count == 4 {
            let picViewWH = imageViewWH * 2 + itemMargin
            return CGSize(width: picViewWH, height: picViewWH)
        }

        // 4.其他张配图
        // 4.1.计算行数
        let rows = CGFloat((count - 1) / 3 + 1)

        // 4.2.计算picView的高度
        let picViewH = rows * imageViewWH + (rows - 1) * edgeMargin

        // 4.3.计算picView的宽度
        let picViewW = UIScreen.mainScreen().bounds.width - 2 * edgeMargin

        return CGSize(width: picViewW, height: picViewH)

    }
}


