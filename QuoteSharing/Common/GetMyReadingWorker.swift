//
//  GetMyReadingWorker.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/13/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation
struct GetMyReadBooksWorker {
    private var successAction: (([Book]) -> Void)?
    init(successAction: (([Book]) -> Void)?) {
        self.successAction = successAction
    }
    func execute() {
        guard let id = appSetting.myId else { return }
        DB().getCollection(.readingBooks)
            .whereField("readerId", isEqualTo: id)
            .getDocuments { (snapshot, error) in
                guard let rawData = snapshot?
                    .documents
                    .map({ return $0.data() }) else {
                        self.successAction?([])
                        return
                }
                print(rawData)
        }
    }
}
