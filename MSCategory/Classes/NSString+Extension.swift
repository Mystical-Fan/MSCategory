//
//  NSString+Extension.swift
//  MSCategory
//
//  Created by Fan on 2019/7/1.
//

import Foundation

extension NSString {
    // MARK - 手机号码判断
    var isPhoneNum: Bool {
        get{
            if self.length != 11 {
                return false
            }
            let mobileReg = "(^1[3-9]\\d{9}$)"
            /// 正则规则
            let regex = try? NSRegularExpression(pattern: mobileReg, options: [])
            /// 进行正则匹配
            if let results = regex?.matches(in: self as String, options: [], range: NSRange(location: 0, length: self.length)), results.count != 0 {
                return true
            }
            return false
        }
    }
    
}
