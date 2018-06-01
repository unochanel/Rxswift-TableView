//
//  userSession.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/06/01.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import Foundation

class UserSession {
    static let userDefaults = Foundation.UserDefaults.standard

    struct  Key {
        static let UserSession = "UserSession"
    }
}

extension UserSession {
    static var userSession: Bool? {
        get {
            return userDefaults.bool(forKey: Key.UserSession)
        }
        set {
            userDefaults.set(newValue, forKey: Key.UserSession)
            userDefaults.synchronize()
        }
    }
}
