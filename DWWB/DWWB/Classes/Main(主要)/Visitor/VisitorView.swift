//
//  VisitorView.swift
//  DWWB
//
//  Created by xmg on 16/4/4.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

class VisitorView: UIView {
//    MARK: - 快速通过xib创建view方法
    class func visitorView() -> VisitorView {
        return NSBundle.mainBundle().loadNibNamed("VisitorView", owner: nil, options: nil).first as! VisitorView
    }
}
