//
//  AddReadingWorker.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/13/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation
struct AddToMyReadingWorker {
    var bookId: String
    init(bookId: String) {
        self.bookId = bookId
    }
    func execute() {
        guard let readerId = appSetting.myId else { return }
        let data = [
            "bookId": bookId,
            "readerId": readerId
        ]
        DB().getCollection(.readingBooks)
            .document()
            .setData(data, merge: true)
    }
}
