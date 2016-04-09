//
//  Status.swift
//  DWWB
//
//  Created by xmg on 16/4/9.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

class Status: NSObject {
    // MARK: - 属性
    var created_at : String? { //微博创建时间
        didSet {
            // 1.nil值校验
            guard let created_at = created_at else {
                return
            }

            // 2.对时间处理
            createAtText = NSData.createDateString(created_at)
            print(createAtText)
        }

    }
    var source : String? {     //微博来源
        didSet {
            // 1.nil值校验
            guard let source = source where source != "" else {
                return
            }

            // 2.对来源的字符串进行处理
            // 2.1 获取起始位置和截取的长度
            let startIndex = (source as NSString).rangeOfString(">").location + 1
            let length = (source as NSString).rangeOfString("</").location - startIndex

            // 2.2 截取字符串
            sourceText = (source as NSString).substringWithRange(NSRange(location: startIndex, length: length))
        }
    }
    var text : String?        //微博的正文
    var mid : Int = 0         //微博的ID

    // MARK: - 处理数据的属性
    var sourceText : String?
    var createAtText : String?

    // MARK: - 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()

        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) { }

}
