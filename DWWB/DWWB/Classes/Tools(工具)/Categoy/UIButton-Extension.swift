//
//  UIButton-Extension.swift
//  DWWB
//
//  Created by xmg on 16/4/5.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

extension UIButton {

//    convenience init (imageName : String, bgImageName : String) {
//        self.init()
//
//        setImage(UIImage(named: imageName), forState: .Normal)
//        setImage(UIImage(named: imageName + "_highlighted"), forState: .Normal)
//        setBackgroundImage(UIImage(named: bgImageName), forState: .Normal)
//        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), forState: .Highlighted)
//        sizeToFit()
//
//
//    }

    
    convenience init (imageName : String, bgImageName : String) {
        self.init()

        setImage(UIImage(named: imageName), forState: .Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        setBackgroundImage(UIImage(named: bgImageName), forState: .Normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), forState: .Highlighted)
        sizeToFit()
    }

}
