//
//  Reader.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/13/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
import Firebase

struct Reader {
    var id: String = ""
    var email: String?
    var phone: String?
    var name: String?
    var avatar: String?
    
    init(user: User) {
        id = user.uid
        email = user.email
        phone = user.phoneNumber
        name = user.displayName
        if let avatar = user.photoURL?.absoluteString {
            self.avatar = avatar + "?type=large"
        }
    }
    
    func toDict() -> [String: Any] {
        var dict = ["id": id]
        if let data = email {
            dict["email"] = data
        }
        if let data = phone {
            dict["phone"] = data
        }
        if let data = name {
            dict["name"] = data
        }
        if let data = avatar {
            dict["avatar"] = data
        }
        return dict
    }
}
