//
//  UserAccountViewModel.swift
//  DWWB
//
//  Created by xmg on 16/4/8.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

class UserAccountViewModel {
    // MARK: - 姜磊设计成单例
    static let shareIntance : UserAccountViewModel = UserAccountViewModel()

    // MARK: - 定义属性
    var account : UserAccount?

    // MARK: - 计算属性
    var accountPath : String {
        var accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        accountPath = (accountPath as NSString).stringByAppendingPathComponent("account.plist")
        return accountPath
    }

    var isLogin : Bool {
        if account == nil {
            return false
        }

        guard let expiresDate = account?.expires_date else {
             return false
        }

        return expiresDate.compare(NSDate()) == NSComparisonResult.OrderedDescending
    }

    // MARK: - 重写init()函数
    init () {
        // 1.从沙盒中读取归档的信息
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
    }


}

