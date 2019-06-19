//
//  GetStoriesWorker.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/19/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation

class Story {
    var userId: String?
    var bookId: String?
    var quoteId: String?
    var quoteContent: String?
    var coverImage: String?
    var userAvatar: String?
    var timestamp: Double = 0
    
    init(raw: AnyObject) {
        quoteId = raw["id"] as? String
        userId = raw["quoterId"] as? String
        bookId = raw["bookId"] as? String
        timestamp = raw["timestamp"] as? Double ?? 0
        quoteContent = raw["content"] as? String
    }
}

struct GetStoriesWorker {
    private var successAction: (([Story]) -> Void)?
    init(successAction: (([Story]) -> Void)?) {
        self.successAction = successAction
    }
    
    func execute() {
        var yesterday = Date()
        yesterday.addTimeInterval(-24*3600)
        DB().getCollection(.quotes)
//            .whereField("timestamp", isGreaterThanOrEqualTo: yesterday.timeIntervalSince1970)
            .getDocuments {(snapshot, error) in
                if let _ = error {
                    self.successAction?([])
                    return
                }
                
                guard let queryDoc = snapshot?.documents
                    .compactMap({ $0.data() as AnyObject }) else { return }
                let stories = queryDoc.map({ Story(raw: $0) })
                self.successAction?(stories.sorted(by: { $0.timestamp > $1.timestamp }))
        }

    }
}
