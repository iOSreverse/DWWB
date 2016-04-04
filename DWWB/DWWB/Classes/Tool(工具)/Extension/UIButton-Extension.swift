//
//  UIButton-Extension.swift
//  DWWB
//
//  Created by xmg on 16/4/4.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(imageName : String, bgImageName : String) {
        self.init()

        setImage(UIImage(named: imageName), forState: .Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        setBackgroundImage(UIImage(named: bgImageName), forState: .Normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), forState: .Highlighted)
        sizeToFit()
    }

    class func creatBtn (imageName : String, bgImageName : String) -> UIButton {
//        1.创建btn
        let btn = UIButton(type: .Custom)

//        设置图片
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        btn.setBackgroundImage(UIImage(named: bgImageName), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), forState: .Highlighted)
        btn.sizeToFit()

        return btn

    }


}