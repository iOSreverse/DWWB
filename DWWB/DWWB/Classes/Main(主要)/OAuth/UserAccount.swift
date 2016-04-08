//
//  UserAccount.swift
//  DWWB
//
//  Created by xmg on 16/4/7.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    // MARK: - 属性
    ///授权AccessToken
    var access_token : String?
    ///过期时间-->秒
    var expires_in : NSTimeInterval = 0.0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }

    }
    ///用户ID
    var uid : String?

    ///过期日期
    var expires_date : NSDate?

    ///昵称
    var screen_name : String?

    ///用户的头像地址
    var avatar_large : String?


    // MARK: - 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()

        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

        // MARK: - 重写description属性
        override var description : String {
            return dictionaryWithValuesForKeys(["access_token", "expires_date", "uid", "screen_name", "avatar_large"]).description
    }

    // MARK: - 归档&解档
    ///解档的方法
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        screen_name = aDecoder.decodeObjectForKey("screen_name") as? String

    }

    ///归档方法
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
    }
}


