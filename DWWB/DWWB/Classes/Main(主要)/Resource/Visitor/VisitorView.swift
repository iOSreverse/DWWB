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

}








