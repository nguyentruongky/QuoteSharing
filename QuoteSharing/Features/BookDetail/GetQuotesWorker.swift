//
//  GetQuotesWorker.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/12/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation
struct GetQuotesWorker {
    var bookId: String
    private var successAction: (([Quote]) -> Void)?
    init(bookId: String,
         successAction: (([Quote]) -> Void)?) {
        self.bookId = bookId
        self.successAction = successAction
    }
    
    func execute() {
        DB().getCollection(.quotes)
            .whereField("bookId", isEqualTo: bookId)
            .getDocuments { (snapshot, error) in
                guard let snapshotDictData = snapshot?.documents else {
                    self.successAction?([])
                    return
                }
                let rawData = snapshotDictData.compactMap({ return $0.data() as AnyObject })
                let quotes = rawData.map({ return Quote(raw: $0) })
                self.successAction?(quotes)
        }
    }
}
