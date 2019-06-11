//
//  Book.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

class Book {
    var id: String
    var title: String?
    var author: String?
    var coverImage: UIImage?
    var cover: String?
    
    init() {
        id = UUID().uuidString
    }
    
    init(rawData: AnyObject) {
        id = rawData["id"] as? String ?? UUID().uuidString
        title = rawData["title"] as? String
        author = rawData["author"] as? String
        cover = rawData["cover"] as? String
    }
    
    func toDict() -> [String: Any] {
        var dict = ["id": id]
        if let data = title {
            dict["title"] = data
        }
        
        if let data = author {
            dict["author"] = data
        }
        return dict
    }
}
