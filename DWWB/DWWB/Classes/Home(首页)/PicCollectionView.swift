//
//  PicCollectionView.swift
//  DWWB
//
//  Created by xmg on 16/4/11.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

class PicCollectionView: UICollectionView {

    // MARK: - 定义属性
    var picURLs : [NSURL] = [NSURL]() {
        didSet {
            self.reloadData()
        }
    }

    // MARK: - 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()

        dataSource = self
    }
}

// MARK: - collectionView的数据源方法
extension PicCollectionView : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PicCell", forIndexPath: indexPath) as! PicCollectionViewCell

        // 2.给cell设置数据
        cell.picURL = picURLs[indexPath.item]

        return cell
    }
}

class PicCollectionViewCell: UICollectionViewCell {
    // MARK: - 定义模型属性
    var picURL : NSURL? {
        didSet {
            guard let picURL = picURL else {
                return
            }

            iconView.sd_setImageWithURL(picURL, placeholderImage: UIImage(named: "empty_picture"))
        }
    }

    // MARK: - 控件的属性
    @IBOutlet weak var iconView: UIImageView!
    
}