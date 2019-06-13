//
//  Quote.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/12/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

struct Quote {
    var quoterId: String?
    var quoterName: String?
    var quoterAvatar: String?
    var id: String
    var content: String?
    var timestamp: Double = 0
    var timeString: String?
    var bookId: String?
    
    init(raw: AnyObject) {
        id = raw["id"] as? String ?? UUID().uuidString
        content = raw["content"] as? String
        bookId = raw["bookId"] as? String
        quoterId = raw["quoterId"] as? String
        timestamp = raw["timestamp"] as? Double ?? Date().timeIntervalSince1970
        timeString = Date(timeIntervalSince1970: timestamp).toString()
    }
    
    init() {
        id = UUID().uuidString
        let today = Date()
        timestamp = today.timeIntervalSince1970
        timeString = today.toString()
    }
    
    init(avatar: String, name: String, content: String, timestamp: Double) {
        id = UUID().uuidString
        self.quoterAvatar = avatar
        self.quoterName = name
        self.content = content
        self.timestamp = timestamp
        let date = Date(timeIntervalSince1970: timestamp)
        timeString = date.toString("dd/MM/yyyy")
    }
    
    func toDict() -> [String: Any] {
        var dict: [String : Any] = [
            "id": id,
            "timestamp": Date().timeIntervalSince1970
            ]
        if let data = content {
            dict["content"] = data
        }
        if let data = bookId {
            dict["bookId"] = data
        }
        if let data = quoterId {
            dict["quoterId"] = data
        }
        return dict
    }
}

