//
//  UIBarButtonItem-Extension.swift
//  DWWB
//
//  Created by xmg on 16/4/6.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName : String) {

        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        btn.sizeToFit()

        self.init(customView : btn)

    }

}
