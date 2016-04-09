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
    var created_at : String?  //微博创建时间
    var source : String?      //微博来源
    var text : String?        //微博的正文
    var mid : Int = 0         //微博的ID

    // MARK: - 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()

        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) { }

}
