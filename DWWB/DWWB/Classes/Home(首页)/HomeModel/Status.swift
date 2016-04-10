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
    var created_at : String?   //微博创建时间
    var source : String?      //微博来源
    var text : String?        //微博的正文
    var mid : Int = 0         //微博的ID
    var user : User?

     // MARK: - 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()

        setValuesForKeysWithDictionary(dict)

        // 1.将用户字典转成用户模型对象
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = User(dict: userDict)
        }
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) { }

}


