//
//  1.Setting.swift
//  knCollection
//
//  Created by Ky Nguyen Coinhako on 7/3/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

var appSetting = AppSetting()
struct AppSetting {
    var userId: String? {
        get { return UserDefaults.get(key: "userId") as String? }
        set {
            UserDefaults.set(key: "userId", value: newValue)
        }
    }
    var didLogin: Bool {
        get { return UserDefaults.get(key: "didLogin") as Bool? ?? false }
        set { UserDefaults.set(key: "didLogin", value: newValue) }
    }
    
    var myself: Reader?
}

let space: CGFloat = 24
