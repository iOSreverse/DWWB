//
//  User.swift
//  DWWB
//
//  Created by xmg on 16/4/9.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

class User: NSObject {
    // MARK: - 属性
    var profile_image_url : String?      // 用户的头像
    var screen_name : String?            // 用户的昵称
    var verified_type : Int = -1              // 用户的认证类型
    var mbrank : Int = 0                 // 用户的会员等级

    // MARK: - 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()

        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forKey key: String) {}
}
